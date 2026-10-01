//
//  CoreDataPersistable.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 01/10/26.
//

import CoreData

protocol UUIDIdentifiable: Identifiable {
  var id: String? { get set }
}

// MARK: - Mapping only (child types, no id needed)
protocol CoreDataMappable {
  associatedtype ManagedType: NSManagedObject
  init()
  var keyMap: [PartialKeyPath<Self>: String] { get }
}

extension CoreDataMappable {

  // Managed object -> struct
  init(managedObject: ManagedType?) {
    self.init()
    guard let managedObject else { return }
    for attribute in managedObject.entity.attributesByName.keys {  // attributes only, not relationships
      if let keyPath = keyMap.first(where: { $0.value == attribute })?.key {
        storeValue(managedObject.value(forKey: attribute), toKeyPath: keyPath)
      }
    }
  }

  private mutating func storeValue(_ value: Any?, toKeyPath partial: AnyKeyPath) {
    switch partial {
    case let keyPath as WritableKeyPath<Self, URL?>:    self[keyPath: keyPath] = value as? URL
    case let keyPath as WritableKeyPath<Self, Int?>:    self[keyPath: keyPath] = value as? Int
    case let keyPath as WritableKeyPath<Self, String?>: self[keyPath: keyPath] = value as? String
    case let keyPath as WritableKeyPath<Self, Bool?>:   self[keyPath: keyPath] = value as? Bool
    default: return
    }
  }

  // Struct -> existing managed object (used to update children in place)
  @discardableResult
  func apply(to object: ManagedType) -> ManagedType {
    for (keyPath, attribute) in keyMap {
      object.setValue(Self.unwrap(self[keyPath: keyPath]), forKey: attribute)
    }
    return object
  }

  // Struct -> new managed object
  @discardableResult
  func toManagedObject(
    context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
  ) -> ManagedType {
    apply(to: ManagedType(context: context))
  }

  // Optional boxed inside Any -> real value or nil
  private static func unwrap(_ any: Any) -> Any? {
    let mirror = Mirror(reflecting: any)
    guard mirror.displayStyle == .optional else { return any }
    return mirror.children.first?.value
  }
}

// MARK: - Root entities (id + upsert)
protocol CoreDataPersistable: CoreDataMappable, UUIDIdentifiable {}

extension CoreDataPersistable {

  func existingObject(
    context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
  ) -> ManagedType? {
    guard let id else { return nil }
    let request = NSFetchRequest<ManagedType>(
      entityName: ManagedType.entity().name ?? String(describing: ManagedType.self))
    request.predicate = NSPredicate(format: "id == %@", id)
    request.fetchLimit = 1
    return try? context.fetch(request).first
  }

  // Overrides the "always create new" version: finds by id, else creates
  @discardableResult
  func toManagedObject(
    context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
  ) -> ManagedType {
    let object = existingObject(context: context) ?? ManagedType(context: context)
    return apply(to: object)
  }

  func save(
    context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
  ) throws {
    if context.hasChanges { try context.save() }
  }
}
