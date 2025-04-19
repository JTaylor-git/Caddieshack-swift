import Foundation
//import MLCChat

class LocalCaddyLLM: ObservableObject {
    private var chatModule: ChatModule?

    init() {
        loadModel()
    }

    func loadModel() {
        do {
            self.chatModule = ChatModule(modelPath: "dist", modelLib: "dist/mlc-chat.so")
        }
            print("Failed to load model: (error)")
    }

    func ask(_ message: String, completion: @escaping (String) -> Void) {
        guard let module = chatModule else {
            completion("LLM not ready.")
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try module.reloadChat()
                module.evaluate(prompt: message) { output in
                    DispatchQueue.main.async {
                        completion(output)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion("LLM Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
