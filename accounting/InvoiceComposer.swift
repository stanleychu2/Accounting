//
//  InvoiceComposer.swift
//  accounting
//
//  Created by 徐胤桓 on 2019/2/20.
//  Copyright © 2019年 邱斯,徐胤桓,陳則明. All rights reserved.
//

import Foundation
import SQLite


class InvoiceComposer: NSObject {
    
    let contactName = Expression<String>("contactName")
    let productName = Expression<String>("productName")
    let amount = Expression<Int64>("amount")
    let money = Expression<Int64>("money")
    let year = Expression<String>("year")
    let month = Expression<String>("month")
    let day = Expression<String>("day")
    let unit = Expression<String>("unit")
    let serialNum = Expression<String>("serialNum")
    let finish = Expression<Bool>("finish")
    
    var allUnit = [String]()
    let orderDB = Table("order")

    
    
    let pathToInvoiceHTMLTemplate = Bundle.main.path(forResource: "invoice", ofType: "html")
    
    let pathToSingleItemHTMLTemplate = Bundle.main.path(forResource: "single_item", ofType: "html")
    
    let pathToLastItemHTMLTemplate = Bundle.main.path(forResource: "last_item", ofType: "html")
    
    let senderInfo = "員侯果菜行"
    
    let senderPhone = "089231680"
    
    let dueDate = ""
    
    let logoImageURL = "http://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png"
    
    var invoiceNumber: String!
    
    var pdfFilename: String!
    
    override init() {
        super.init()
    }
    
    func renderInvoice(invoiceNumber: String, invoiceDate: String, recipientInfo: String, items: [OrderProduct], totalAmount: String) -> String! {
        
        let filterOrder = orderDB.filter(contactName == recipientInfo && serialNum == invoiceNumber)
        for holdOneUnit in (try? db?.prepare(filterOrder))!! {
            print(holdOneUnit[unit])
            allUnit.append(holdOneUnit[unit])
        }
        
        self.invoiceNumber = invoiceNumber
        
        do {
            // Load the invoice HTML template code into a String variable.
            var HTMLContent = try String(contentsOfFile: pathToInvoiceHTMLTemplate!)
            
            // Replace all the placeholders with real values except for the items.
            // The logo image.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LOGO_IMAGE#", with: logoImageURL)
            
            // Invoice number.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#INVOICE_NUMBER#", with: invoiceNumber)
            
            // Invoice date.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#INVOICE_DATE#", with: invoiceDate)
            
            // Due date (we leave it blank by default).
            HTMLContent = HTMLContent.replacingOccurrences(of: "#DUE_DATE#", with: dueDate)
            
            // Sender info.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#SENDER_INFO#", with: senderInfo)
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "#SENDER_PHONE#", with: senderPhone)

            
            // Recipient info.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#RECIPIENT_INFO#", with: recipientInfo)
            
            // Total amount.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TOTAL_AMOUNT#", with: totalAmount)
            
            // The invoice items will be added by using a loop.
            var allItems = ""
            
            // For all the items except for the last one we'll use the "single_item.html" template.
            // For the last one we'll use the "last_item.html" template.
            for i in 0..<items.count {
                var itemHTMLContent: String!
                
                // Determine the proper template file.
                if i != items.count - 1 {
                    itemHTMLContent = try String(contentsOfFile: pathToSingleItemHTMLTemplate!)
                }
                else {
                    itemHTMLContent = try String(contentsOfFile: pathToLastItemHTMLTemplate!)
                }
                
                // Replace the description and price placeholders with the actual values.
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_DESC#", with: items[i].name)
                
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#AMOUNT#", with: String(items[i].amount))

                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#UNIT_PRICE#", with: String(items[i].unitPrice))

                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#UNIT#", with: allUnit[i])
                
                // Format each item's price as a currency value.
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#PRICE#", with: String((items[i].amount * Float64(items[i].unitPrice)).rounded()))
                
                // Add the item's HTML code to the general items string.
                allItems += itemHTMLContent
            }
            
            // Set the items.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ITEMS#", with: allItems)
            
            // The HTML code is ready.
            return HTMLContent

            
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
        
    }
    
}
