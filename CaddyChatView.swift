// CaddyCaddie/Views/CaddyChatView.swift
import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let sender: String
    let text: String
}

struct CaddyChatView: View {
    @State private var messages: [Message] = []
    @State private var input: String = ""
    @StateObject private var llm = LocalCaddyLLM()
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(messages) { msg in
                        HStack {
                            if msg.sender == "User" {
                                Spacer()
                                Text(msg.text)
                                    .padding()
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                            } else {
                                Text(msg.text)
                                    .padding()
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(10)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                HStack {
                    TextField("Ask your caddy...", text: $input)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(isLoading)
                    Button("Send") {
                        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmed.isEmpty else { return }
                        messages.append(Message(sender: "User", text: trimmed))
                        isLoading = true
                        llm.ask(trimmed) { response in
                            messages.append(Message(sender: "Caddy", text: response))
                            isLoading = false
                        }
                        input = ""
                    }
                    .disabled(isLoading)
                }
                .padding()
            }
            .navigationTitle("AI Caddy")
        }
    }
}
