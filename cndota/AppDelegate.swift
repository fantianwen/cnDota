//
//  AppDelegate.swift
//  cndota
//
//  Created by 范天文 on 16/3/4.
//  Copyright © 2016年 范天文. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var lable1: NSTextField!
    @IBOutlet weak var button1: NSButton!
    @IBOutlet weak var button2: NSButton!
    
    
    @IBOutlet weak var pmTimeLable: NSTextField!
    @IBOutlet weak var amTimeLable: NSTextField!
    
    @IBOutlet weak var amTimeHour: NSTextField!
    @IBOutlet weak var amTimeMimute: NSTextField!
    
    @IBOutlet weak var pmTimeHour: NSTextField!
    @IBOutlet weak var pmTimeMimute: NSTextField!
    
    var state:Bool=false
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {

        amTimeLable.stringValue = "上班时间设定"
        pmTimeLable.stringValue = "下班时间设定"
        
//        executeCommand("/usr/local/bin/python3", args: ["/Users/RadAsm/pythonProjects/auto_login/daka/main.py"])

//        let timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "exeCommand", userInfo: nil, repeats: true)
//        timer.fire()
        lable1.stringValue = "ようこそ~"
        
        
        button1.title = "自动打卡"
        
        button2.title = "中断打卡"
    
        
    }
    
    
    func exeCommand()->Void{
        print("timer start....")
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func start(sender:AnyObject){
        let timePrefix = getTimePrefix()
        let timeSuffix = "\(amTimeHour.stringValue):\(amTimeMimute.stringValue):00"

        let settedTime = "\(timePrefix)\(timeSuffix)"
        
        let intervalTime = getTimeInterval(settedTime)
        
        showNotification("少女祈祷中~")
        if showAlert(){
            lable1.stringValue="working。。。"
            showNotification("施法成功 :-D")
            state = true
            
            
            amDispatch(intervalTime){
                
//                self.executeCommand("/usr/local/bin/python3", args: ["/Users/RadAsm/pythonProjects/auto_login/daka/main.py"])
                print("this is fucking awesome!")
                
            }
            
            
            
        }else{
            showNotification("祈祷失败的说~")
            state = false
        }
        
    }
    
    
    
    @IBAction func pauseTask(sender:AnyObject){
        
        showNotification("少女累了？")
        
        if showPauseAlert(){
            lable1.stringValue="pausing。。。"
            if state{
                showNotification("吟唱终止~")
                state = false
            }else{
                showNotification("少女外出中~")
                state = false
            }
            
            
        }else{
            if state{
                showNotification("少女更加卖力了呢~")
                
            }else{
                showNotification("少女不干了~╭(╯^╰)╮")
            }
            
            
        }
    
    }
    
    
    func executeCommand(command: String, args: [String]) -> String {
        
        let task = NSTask()
        
        task.launchPath = command
        task.arguments = args
        
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
        
        return output
    }
    
    func showNotification(msg:String) -> Void {
        let notification = NSUserNotification()
        notification.title = "魔法状态"
        notification.informativeText = msg
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
        
        
    }
    
    func showAlert()->Bool{
        let alertView:NSAlert = NSAlert()
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Cancle")
        alertView.messageText = "hehehehehe"
        alertView.informativeText = "fantianwen is fucking awesome!"
        let res = alertView.runModal()
        if res == NSAlertFirstButtonReturn{
            return true
        }
        return false
 
    }
    
    
    func showPauseAlert()->Bool{
        let alertView:NSAlert = NSAlert()
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Cancle")
        alertView.messageText = "中断提醒"
        alertView.informativeText = "确定要停止提醒么？"
        let res = alertView.runModal()
        if res == NSAlertFirstButtonReturn{
            return true
        }
        return false
    }
    
    
    func amDispatch(delay:Double,closure:()->()){
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }
    
    
    func getTimePrefix()->String{
        
        let now = NSDate()
        let das = NSCalendar.currentCalendar()

        let nowCom = das.components([.NSYearCalendarUnit,.NSMonthCalendarUnit,.NSDayCalendarUnit,.NSHourCalendarUnit,.NSMinuteCalendarUnit,.NSSecondCalendarUnit], fromDate: now)
        
        let year = nowCom.year
        let month = nowCom.month
        let day = nowCom.day
//        let hour = nowCom.hour
//        let minute = nowCom.minute
//        let second = nowCom.second
        
//        return "\(year)-\(month)-\(day) \(hour):\(minute):\(second)"
        return "\(year)-\(month)-\(day) "

    }
    

    
    
    func getTimeInterval(date:String)->Double{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        let dateSet = dateFormatter.dateFromString(date)
        let delta = NSDate().timeIntervalSinceDate(dateSet!)
        
        return -delta
        
    }
    
    
}

