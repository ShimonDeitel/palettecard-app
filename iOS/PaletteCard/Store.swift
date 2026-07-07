import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published private(set) var items: [Mix] = []
    @Published var isProUnlocked: Bool = false

    /// Free-tier cap. Seed data ships with 3 items, so this is set well above
    /// that to guarantee a fresh install never trips the paywall immediately.
    static let freeLimit = 15

    private let fileURL: URL

    init() {
        let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let dir = support.appendingPathComponent("PaletteCard", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("mixes.json")
        load()
    }

    var isAtFreeLimit: Bool {
        !isProUnlocked && items.count >= Store.freeLimit
    }

    func canAdd() -> Bool {
        isProUnlocked || items.count < Store.freeLimit
    }

    func add(_ item: Mix) {
        guard canAdd() else { return }
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: Mix) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Mix) {
        items.removeAll(where: { $0.id == item.id })
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Mix].self, from: data) {
            items = decoded
        } else {
            items = Store.seedData
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static let seedData: [Mix] = [
        Mix(title: "Sunset Umber", baseColors: "Burnt Sienna 3 : Titanium White 1 : Cad Yellow 1", medium: "Oil", notes: "Great for skin shadow"),
        Mix(title: "Storm Teal", baseColors: "Phthalo Blue 2 : Raw Umber 1 : White 1", medium: "Acrylic", notes: "Mix Phthalo last, very strong"),
        Mix(title: "Dusty Rose", baseColors: "Alizarin Crimson 1 : White 3 : Yellow Ochre touch", medium: "Watercolor", notes: "Light wash for portraits")
    ]
}
