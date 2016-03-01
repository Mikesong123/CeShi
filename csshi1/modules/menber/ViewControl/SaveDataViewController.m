//
//  SaveDataViewController.m
//  csshi1
//
//  Created by 高 on 16/1/30.
//  Copyright © 2016年 高. All rights reserved.
//

#import "SaveDataViewController.h"
#import <sqlite3.h>

@interface SaveDataViewController ()
{
     NSString *databasePath;
    sqlite3 *contactsDB;//自己定义一个sqlite3的成员变量.进行正删改查时要用.
}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *addres;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end

@implementation SaveDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *docsDir;
    NSArray *dirPaths;
     /*根据路径创建数据库并创建一个表contact(id nametext addresstext phonetext)*/
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    // Get the documents directory
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"contacts.db"]];
    NSFileManager *filemge = [NSFileManager defaultManager];
    if ([filemge fileExistsAtPath:databasePath] == NO) {
        const char*dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &contactsDB) == SQLITE_OK) {//打开或者创建一个数据
            char *eromsg;
            const char *sql_stml = "CREATE TABLE IF NOT EXISTS CONTACTS(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT,ADDRESS TEXT,PHONE TEXT)";// 需要执行的数据库语句
            if (sqlite3_exec(contactsDB, sql_stml, NULL, NULL, &eromsg)!=SQLITE_OK) {//该函数可进行insert,delete,update操作.
                self.status.text = @"创建表失败\n";
            }
        }else{
             self.status.text = @"创建/打开数据库失败";
        }
    }
}

- (IBAction)SaveToData:(id)sender {
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &contactsDB) == SQLITE_OK) {
        NSString *inserSQL = [NSString stringWithFormat:@"INSERT INTO CONTACTS(name,address,phone) VALUES(\"%@\",\"%@\",\"%@\")",self.name.text,self.addres.text,self.phone.text];
        const char *inert_stmt = [inserSQL UTF8String];
        sqlite3_prepare_v2(contactsDB, inert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement)==SQLITE_DONE) {
            self.status.text = @"已存储到数据库";
            self.name.text = @"";
            self.addres.text = @"";
            self.phone.text = @"";
        } else {
            self.status.text = @"保存失败";
        }
        sqlite3_finalize(statement);//把刚才分配的内容析构掉
        sqlite3_close(contactsDB);
    }
}
- (IBAction)SearchFromData:(id)sender {
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    //
    if (sqlite3_open(dbpath, &contactsDB)==SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT address,phone from contacts where name=\"%@\"",self.name.text];
        const char *qery_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactsDB, qery_stmt, -1, &statement, NULL)==SQLITE_OK) {//做查询前准备,检测SQL语句是否正确.
            if (sqlite3_step(statement)==SQLITE_ROW) {//提取查询到的数据,一次提取一条.
                NSString *addressField = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];//取出第0列的数据.
                self.addres.text = addressField;
                NSString *phonefeild = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
                self.phone.text = phonefeild;
                self.status.text = @"已查到结果";
            }else{
                self.phone.text = @"未查到结果";
                self.addres.text = @"";
                self.phone.text = @"";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactsDB);
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
//    // Release any retained subviews of the main view.
    self.name = nil;
    self.addres = nil;
    self.phone = nil;
    self.status = nil;
}

@end
