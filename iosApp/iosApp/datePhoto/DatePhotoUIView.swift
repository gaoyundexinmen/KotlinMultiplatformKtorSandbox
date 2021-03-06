//
//  DatePhotoUIView.swift
//  MultiplatformKtor
//
//  Created by Артем on 27.06.2020.
//  Copyright © 2020 Gaoyun. All rights reserved.
//

import SwiftUI
import app
import URLImage

struct DatePhotoUIView: View {
    
    @ObservedObject var controller = DatePhotoViewController()
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Text(self.controller.currentDate)
                            .frame(width: geometry.size.width)
                            .padding(EdgeInsets(top: 8.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                        if(self.controller.currentPhoto != nil) {
                            URLImage(self.controller.currentPhoto!,
                                     placeholder: {_ in Text("Image...")},
                                     content: {
                                        $0.image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                            .padding(.all, 10.0)
                                            .shadow(radius: 10.0)
                            })
                        } else {
                            Text("Image...").padding(EdgeInsets.init(top: 32.0, leading: 32.0, bottom: 32.0, trailing: 32.0))
                        }
                        Text(self.controller.currentPhotoAuthor)
                        Button(action: {self.controller.getFstPhotoFromDb()}){
                            Text("Get 1-st photo from DB")
                        }.padding(EdgeInsets.init(top: 32.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                        Button(action: {self.controller.getSndPhotoFromDb()}){
                            Text("Get 2-nd photo from DB")
                        }.padding(EdgeInsets.init(top: 16.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                        Button(action: {self.controller.getPhotoFromApi()}){
                            Text("Fetch photo from API")
                        }.padding(EdgeInsets.init(top: 16.0, leading: 0.0, bottom: 32.0, trailing: 0.0))
                    }
                }
            }
            .navigationBarTitle("Kotlin Multiplatform", displayMode: .large)
        }
        .onAppear {
            self.controller.initDateView()
            self.controller.initPhotosPresenter()
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct DatePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        DatePhotoUIView()
    }
}
