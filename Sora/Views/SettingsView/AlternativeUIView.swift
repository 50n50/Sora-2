//
//  AlternativeUIView.swift
//  Sora
//
//  Created by Francesco on 20/08/25.
//

import SwiftUI

struct AlternativeUIView: View {
    @AppStorage("seasonMenu") private var useSeasonMenu = false
    @AppStorage("horizontalEpisodeList") private var horizontalEpisodeList = false
#if !os(tvOS)
    @AppStorage("useCustomTabBar") private var useCustomTabBar: Bool = {
        if #available(iOS 26, *) {
            return false
        } else {
            return true
        }
    }()
#endif
    
    @StateObject private var accentColorManager = AccentColorManager.shared
    
    var body: some View {
        List {
            Section {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Accent Color")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Text("This affects buttons, links, and other interactive elements.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    ColorPicker("", selection: $accentColorManager.currentAccentColor)
                        .onChange(of: accentColorManager.currentAccentColor) { newColor in
                            accentColorManager.saveAccentColor(newColor)
                        }
                }
            } header: {
                Text("Interface")
            }
            
            Section {
                NavigationLink(destination: HomeSectionsView()) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Home Sections")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Text("Customize which sections appear on the home screen and reorder them")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                #if !os(tvOS)
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Custom Tab Bar")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Text("Use custom tab bar instead of native iOS tab bar")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $useCustomTabBar)
                        .tint(accentColorManager.currentAccentColor)
                }
                #endif
                
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Alternative Season Menu")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Text("Use dropdown menu instead of horizontal scroll for seasons")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $useSeasonMenu)
                        .tint(accentColorManager.currentAccentColor)
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Horizontal Episode list ")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Text("Use Horizontal list instead of vertical episode list")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $horizontalEpisodeList)
                        .tint(accentColorManager.currentAccentColor)
                }
            } header: {
                Text("DISPLAY OPTIONS")
            } footer: {
                Text("The alternative season menu uses a dropdown instead of a horizontal scroll for selecting seasons.")
            }
        }
        .navigationTitle("Appearance")
    }
}

#Preview {
    NavigationView {
        AlternativeUIView()
    }
}
