//
//  GroupBox Headline Group.swift
//  McBrew
//
//  Created by alienator88 on 10.02.2023.
//

import SwiftUI

struct GroupBoxHeadlineGroup: View
{
    var image: String?
    let title1: String
    let title2: String
    let count: String
    let mainText: String

    var body: some View
    {
        HStack(spacing: 15)
        {
            if let image
            {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
            }

            VStack(alignment: .leading, spacing: 2)
            {
                HStack(spacing: 0) {
                    Text(title1)
                    Text(count).bold()
                    Text(title2)
                }
                Text(mainText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(10)
    }
}

struct GroupBoxHeadlineGroupAnalytics: View
{
    var image: String?
    let title: String
    let status: String
    let mainText: String

    var body: some View
    {
        HStack(spacing: 15)
        {
            if let image
            {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
            }

            VStack(alignment: .leading, spacing: 2)
            {
                HStack(spacing: 0) {
                    Text(title)
                    Text(status).bold()
                }
                Text(mainText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(10)
    }
}

struct GroupBoxHeadlineGroupPaths: View
{
    var image: String?
    let title: String
    let a1: String
    let a2: String
    let b1: String
    let b2: String
    let c1: String
    let c2: String
    let d1: String
    let d2: String

    var body: some View
    {
        HStack(spacing: 15)
        {
            if let image
            {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
            }

            VStack(alignment: .leading, spacing: 2)
            {
                Text(title)
                
                HStack(spacing: 0){
                    Text(a1)
                        .foregroundColor(.secondary)
                        .bold()
                    Text(a2)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                HStack(spacing: 0){
                    Text(b1)
                        .foregroundColor(.secondary)
                        .bold()
                    Text(b2)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                HStack(spacing: 0){
                    Text(c1)
                        .foregroundColor(.secondary)
                        .bold()
                    Text(c2)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                HStack(spacing: 0){
                    Text(d1)
                        .foregroundColor(.secondary)
                        .bold()
                    Text(d2)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(10)
    }
}
