//
//  API.swift
//  Wlite
//
//  Created by Pinuno Fuentes on 7/24/15.
//  Copyright (c) 2015 Pinuno Fuentes. All rights reserved.
//

import Foundation
import Alamofire

public class API {
    
    public let user: UserEndpoint = UserEndpoint()
    public let list: ListEndpoint = ListEndpoint()
    public let task: TaskEndpoint = TaskEndpoint()
    
    let completionHandler = {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
        if (error != nil) {
            println("error: \(error)")
            println("response: \(response)")
        }
        if (JSON != nil) {
            println("result: \(JSON!)")
        }
    }
    
    
    // MARK: Avatar
    
    func readAvatarForUser(userid: Int) {
        // FIXME
        let parameters : [ String : AnyObject] = [
            "user_id": userid
        ]
        Alamofire
            .request(AvatarRouter.ReadAvatar(parameters))
            .response { (request, response, result, error) -> Void in
                if (error != nil) {
                    println("error: \(error)")
                    println("response: \(response)")
                }
                else {
                    println("error: \(result)")
                    println("response: \(response)")
                }
        }
        //            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    // MARK: Files
    
    func readFilesForTask(taskid:Int){
        // TODO: Implement
    }
    
    func readFilesForList(listid:Int){
        // TODO: Implement
    }
    
    func readFile(fileid: Int) {
        // TODO: Implement
    }
    
    func createFileForTask(taskid:Int, withUpload uploadid:Int, createdate date:NSDate) {
        // TODO: Implement
    }
    
    func deleteFile(fileid:Int, withRevision revision:Int) {
        // TODO: Implement
    }
    
    // MARK: File preview
    
    func readFilePreviewsForFile(fileid:Int) {
        // TODO: Implement
    }
    
    // MARK: Folder
    
    func readFolders(){
        Alamofire
            .request(FolderRouter.ReadFolders())
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func readFolder(folderid:Int) {
        Alamofire
            .request(FolderRouter.ReadFolder("\(folderid)"))
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func createFolderWithTitle(title:String, lists listids:[Int]) {
        // TODO: this
    }
    
    func updateFolder(folderid: Int, withRevision revision: String, title newtitle:String, lists listids:[Int]) {
        // TODO: this
    }
    
    func deleteFolder(folderid: Int, withRevision revision: String) {
        // TODO: this
    }
    
    func readFolderRevisions(){
        Alamofire
            .request(FolderRouter.ReadFolderRevisions())
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    // MARK: List
    
    func readLists() {
        Alamofire
            .request(ListRouter.ReadLists())
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func readList(listid: Int) {
        Alamofire
            .request(ListRouter.ReadList("\(listid)"))
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func createListWithTitle(title: String){
        let parameters : [ String : AnyObject] = [
            "title": title
        ]
        Alamofire
            .request(ListRouter.CreateList(parameters))
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func updateList(listid: Int, withRevision revision: Int, title newtitle: String){
        // TODO: this
    }
    
    func updateList(listid: Int, withRevision revision: Int, publicflag ispublic: Bool){
        // TODO: this
    }
    
    func deleteList(listid: Int, withRevision revision: Int){
        // TODO: this
    }
    
    // MARK: Membership
    
    func readMemberships() {
    }
    
    func createMembershipForList(listid: Int, withUserid userid: Int, mutedflag ismuted: Bool){
        // TODO: this
    }
    
    func createMembershipForList(listid: Int, withEmail email: String, mutedflag ismuted: Bool){
        // TODO: this
    }
    
    func updateMembership(membershipid: Int, withRevision revision: Int, state newstate: String, mutedflag ismuted: Bool) {
        // set state = "accepted" to mark a member as accepted
        // TODO: this
    }
    
    func deleteMembership(membershipid: Int, withRevision revision: Int) {
        // use this to 1) remove a member from a list, or 2) reject an invite to a list
        // TODO: this
    }
    
    // MARK: Note
    
    func readNotesForTask(taskid: Int){
        // TODO: this
    }
    
    func readNotesForList(listid: Int) {
        // TODO: this
    }
    
    func readNote(noteid: Int){
        // TODO: this
    }
    
    func createNoteForTaks(taskid:Int, withContent content: String) {
        // TODO: this
    }
    
    func updateNote(noteid: Int, withRevision revision: Int, content newcontent: String){
        // TODO: this
    }
    
    func deleteNote(noteid: Int, withRevision revision: Int){
        // TODO: this
    }
    
    // MARK: List Positions
    
    func readListPositions(){
        // TODO: this
    }
    
    func readListPosition(listpositionid: Int){
        // TODO: this
    }
    
    func updateListPosition(listpositionid: Int, withRevision revision: Int, orderedlists listids: [Int]){
        // TODO: this
    }
    
    // MARK: Task Positions
    
    func readTaskPositionsForList(listid: Int) {
        // TODO: this
    }
    
    func readTaskPosition(taskpositionid: Int) {
        // TODO: this
    }
    
    func updateTaskPosition(taskpositionid: Int, withRevision revision: Int, orderedtasks taskids: [Int]){
        // TODO: this
    }
    
    // MARK: Task Positions
    
    func readSubtaskPositionsForTask(taskid: Int){
        // TODO: this
    }
    
    func readSubtaskPositionsForList(listid: Int){
        // TODO: this
    }
    
    func readSubtaskPosition(subtaskpositionid: Int){
        // TODO: this
    }
    
    func updateSubtaskPosition(subtaskpositionid: Int, withRevision revision: Int, orderedsubtasks subtaskids: [Int]) {
        // TODO: this
    }
    
    // MARK: Reminder
    
    func readRemindersForTask(taskid: Int){
        // TODO: this
    }
    
    func readRemindersForList(listid: Int){
        // TODO: this
    }
    
    func readRemindersForList(listid: Int, withCompletedFlag iscompleted:Bool){
        // TODO: this
        // add completed_tasks:Bool to parameter
    }
    
    func createReminderForTask(taskid: Int, withDate date: String){
        // TODO: this
    }
    
    func updateReminder(reminderid: Int, withRevision revision: Int, date newdate: String){
        // TODO: this
    }
    
    func deleteReminder(reminderid: Int, withRevision revision: Int) {
    }
    
    // MARK: Subtask
    
    func readSubtasksForTask(taskid: Int, withCompletedFlag iscompleted: Bool){
        // TODO: this
    }
    
    func readSubtasksForList(listid: Int, withCompletedFlag iscompleted: Bool){
        // TODO: this
    }
    
    func readSubtask(subtaskid: Int){
        // TODO: this
    }
    
    func createSubtaskForTask(taskid: Int, withTitle: String, completedFlag iscompleted: Bool) {
        // TODO: this
    }
    
    func updateSubtask(subtaskid: Int, withRevision revision: Int, title newtitle: String) {
        // TODO: this
    }
    
    func deleteSubtask(subtaskid: Int, withRevision revision: Int) {
        // TODO: this
    }
    
    // MARK: Task
    
    func readTasksForList(listid: Int, withCompletedFlag iscompleted: Bool?) {
        // TODO: this
        //        Alamofire
        //            .request(CTaskRouter.ReadTasks())
        //            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func readTask(taskid: Int){
        // TODO: this
    }
    
    func createTaskForList(listid:Int, withTitle title: String){
        let parameters : [ String : AnyObject] = [
            "title": title,
            "list_id": listid
        ]
        Alamofire
            .request(TaskRouter.CreateTask(parameters))
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func updateTask(taskid: Int, withRevision revision: Int, title newtitle: String){
        // TODO: this
    }
    
    func deleteTask(taskid: Int, withRevision revision: Int){
        // TODO: this
    }
    
    // MARK: Task Comment
    
    func readTaskCommentsForTask(taskid: Int, withCompletedFlag iscompleted: Bool?){
        // TODO: this
    }
    
    func readTaskCommentsForList(listid: Int, withCompletedFlag iscompleted: Bool?){
        // TODO: this
    }
    
    func readTaskComment(taskcommentid: Int) {
        // TODO: this
    }
    
    func createTaskCommentForTask(taskid: Int, withText text: String) {
        // TODO: this
    }
    
    // MARK: Upload
    
    func createUploadWithFileName(filename: String, fileType type: String, fileSize size: Int, partNumber number: Int?, md5sum md5sumvalue: String?){
    }
    
    func readUploadPart(partnumber: Int, forUpload uploadid: Int, withMd5sum md5sumvalue: String?){
        // TODO: this
    }
    
    func updateUpload(uploadid: Int, withState state:String) {
        // set state = "finished" to mark the upload as finished
        // TODO: this
    }
    
    // MARK: User
    
//    func readUser(){
//        Alamofire
//            .request(UserRouter.ReadUser())
//            .responseJSON(options: nil, completionHandler: completionHandler)
//    }
    
    func readUsers(withAccessToList:Int?) {
        // TODO: this
    }
    
    // MARK: Webhook
    
    func readWebhooksForList(listid: Int) {
        // TODO: this
    }
    
    func createWebhookForList(listid:Int, withURL url: String, processorType type: String, configuration config: String){
        // TODO: this
    }
    
    func deleteWebhook(webhookid: Int, withRevision revision:Int){
        // TODO: this
    }

}





