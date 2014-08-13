//
//  AppDelegate.m
//  Proto
//
//  Created by 安倍裕貴 on 2014/08/05.
//  Copyright (c) 2014年 Yuki Abe. All rights reserved.
//

#import "AppDelegate.h"
#import "Area.h"
#import "Country.h"
#import "Hotel.h"

@implementation AppDelegate


@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Arealist" ofType:@"csv"];
//    NSLog(@"%@", path);
//    NSString *csv = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    NSArray *result = [csv arrayByImportingCSV];
//    NSLog(@"%@",result);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AreaList" ofType:@"csv"];
    //NSLog(@"%@", path);
    NSString *csv = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *result = [csv arrayByImportingCSV];
    //NSLog(@"%@",result);
    
    
    NSManagedObjectContext *context = [self managedObjectContext];

    for (NSArray *areaArray in result) {
        //データベースやテーブルにデータを挿入するためのオブジェクトがplaceだよ。
        Area *area = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Area class]) inManagedObjectContext:context];
        //名前を取り出す
        area.name = areaArray[1];
        
        //エラーが起きたときに表示する
        //&を使うとエラー情報をセットして戻す事ができる。内部エラーを取り出す。
        NSError *error = nil;
        if (![context save:&error]) {
            abort(); //エラーが起きたら処理を中止する
        }
     
        
        
    }
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"country" ofType:@"csv"];
    NSLog(@"%@", path2);
    NSString *csv2 = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    NSArray *result2 = [csv2 arrayByImportingCSV];
    NSLog(@"%@",result2);
    
    
//    NSManagedObjectContext *context2 = [self managedObjectContext];
    
    for (NSArray *countryArray in result2) {
        //データベースやテーブルにデータを挿入するためのオブジェクトがplaceだよ。
        Country *area2 = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Country class]) inManagedObjectContext:context];
        //名前を取り出す
        area2.name = countryArray[0];
        
        //エラーが起きたときに表示する
        //&を使うとエラー情報をセットして戻す事ができる。内部エラーを取り出す。
        NSError *error = nil;
        if (![context save:&error]) {
            abort(); //エラーが起きたら処理を中止する
        }
    }
    
    
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"hotel3" ofType:@"csv"];
    NSLog(@"%@", path3);
    NSString *csv3 = [NSString stringWithContentsOfFile:path3 encoding:NSUTF8StringEncoding error:nil];
    NSArray *result3 = [csv3 arrayByImportingCSV];
    NSLog(@"%@",result3);
    
    
    //NSManagedObjectContext *context3 = [self managedObjectContext];
    
    for (NSArray *hotelArray in result3) {
        //データベースやテーブルにデータを挿入するためのオブジェクトがplaceだよ。
        Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Hotel class]) inManagedObjectContext:context];
        //名前を取り出す
        hotel.zipcode = hotelArray[0];
        hotel.name = hotelArray[1];
        hotel.url = hotelArray[2];
        hotel.detail = hotelArray[3];
        
        
        //エラーが起きたときに表示する
        //&を使うとエラー情報をセットして戻す事ができる。内部エラーを取り出す。
        NSError *error = nil;
        if (![context save:&error]) {
            abort(); //エラーが起きたら処理を中止する
        }
        

    }
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Proto" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.

- (void)createDictionary
{
//    // Create a new instance of the entity managed by the fetched results controller.
//    NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
//    //    NSManagedObjectContext *context = [self.managedObjectContext]
//    //NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"Arealist" ofType:@"csv"];
    NSString *csv = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *result = [csv arrayByImportingCSV];
    NSLog(@"%@",result);
    
}



- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Proto.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end

