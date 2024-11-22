//
//  UserSettingsView.swift
//  Memo cubes
//
//  Created by Pavel Andreev on 9/23/24.
//

import SwiftUI

struct UserSettingsView: View {
    
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    UserSettingsView()
}
