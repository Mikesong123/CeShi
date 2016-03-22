//
//  FMDBViewController.m
//  csshi1
//
//  Created by 高 on 16/2/3.
//  Copyright © 2016年 高. All rights reserved.
//

#import "FMDBViewController.h"
#import "Student.h"
#import <sqlite3.h>
#import <FMDB.h>

@interface FMDBViewController ()<NSCoding>
{
    NSMutableArray *ceshi1;
    NSMutableArray *ceshi2;
    NSArray *arr;
    sqlite3 *sqlite;
    FMDatabase *databse;
}
@property(assign ,getter=ison)BOOL on;
@property(nonatomic ,strong)NSString *wstring;

@end

@implementation FMDBViewController
//@synthesize wstring = _wstring;
@dynamic wstring ;

- (instancetype)init{
    self = [super init];
    if (self) {
        arr = @[@"11",@"12",@"13"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = M1905_UIColorFromRGB(0xf2f2f2);
    // Do any additional setup after loading the view.
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filename = [path stringByAppendingPathComponent:@"t_student.sqlite"];
//    [self cunzhi];
//    [self quzhi];
    //
//    [self openDatabase];
//    [self insertData];
//    [self readData];
    //
    [self openFmdb];
    [self chuangjianbiaoge];
    [self charushuju];
    [self chaxunshiwu];
}
- (void)plist{
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [document stringByAppendingPathComponent:@"data.plist"];
    NSArray *aarr = @[@"11",@"12",@"13"];
    [aarr writeToFile:path atomically:YES];
    
    NSArray *arra = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"plist---%@",arra);
}

- (void)nsuserDefault{
    NSUserDefaults *defalt = [NSUserDefaults standardUserDefaults];
    [defalt setObject:@"123" forKey:@"123"];
    [defalt synchronize];
    
//    NSString *obj = defalt[@"123"];
    NSString *obj = [defalt objectForKey:@"123"];
    NSLog(@"nsuserdefalt -- %@",obj);
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];//自定义子类采用
    [aCoder encodeObject:@"456" forKey:@"456"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{//nsobject
//    [super initWithCoder:aDecoder];
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSString *nskey = [aDecoder decodeObjectForKey:@"456"];
    }
    return self;
}

- (void)nskeyedachiever{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.data"];
    Student *stu = [[Student alloc] init];
    stu.name = @"wo";
    [NSKeyedArchiver archiveRootObject:stu toFile:path];
}
- (void)unnskeyedachiever{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.data"];
    Student *stu = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"unnskey---%@",stu.name);
}
- (void)cunzhi {
    NSUserDefaults *defalt = [NSUserDefaults standardUserDefaults];
    [defalt setObject:[NSKeyedArchiver archivedDataWithRootObject:arr] forKey:@"ceshiary"];
    [defalt synchronize];
}
- (void)quzhi {
    NSData *ary =[[NSUserDefaults standardUserDefaults] objectForKey:@"ceshiary"];
    NSArray *quzhi = [NSKeyedUnarchiver unarchiveObjectWithData:ary];
    NSLog(@"+++++++%@",quzhi);
}

//sqlite3
//创建
-(void)openDatabase{
    //设置文件名
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).lastObject stringByAppendingPathComponent:@"person.db"];
    //打开数据库文件，如果没有会自动创建一个。
    NSInteger result = sqlite3_open(path.UTF8String, &sqlite);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库文件");
        //建表
        char *errmsg = NULL;
        sqlite3_exec(sqlite, "CREATE TABLE IF NOT EXISTS t_person(id integer primary key autoincrement, name text, age integer)", NULL, NULL, &errmsg);
        if (errmsg) {
            NSLog(@"建表成功");
        }else{
            NSLog(@"建表失败");
        }
    }else{
        NSLog(@"打开数据库文件失败");
    }
}

- (void)insertData{
    NSString *name = @"sqlite insert data";
    NSInteger count = 40;
    char  *errmsg;
    NSString *operation = [NSString stringWithFormat:@"INSERT INTO t_person(name,age) VALUE('%@','%ld',)",name,count];
    sqlite3_exec(sqlite, operation.UTF8String, NULL, NULL, &errmsg);
    if (errmsg) {
        NSLog(@"错误：%s",errmsg);
    }else{
        NSLog(@"插入成功");
    }
}

- (void)readData {
    char *sql = "select name, age from t_person;";
    sqlite3_stmt *stmt;
    NSInteger result = sqlite3_prepare_v2(sqlite, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            char *name = (char *)sqlite3_column_text(stmt, 0);
            NSInteger age = sqlite3_column_int(stmt, 1);
            //创建对象
            Student *person = [[Student alloc] init];
            //personWithName:[NSString stringWithUTF8String:name] Age:age];
            person.name = [NSString stringWithUTF8String:name];
            person.age = age;
            NSLog(@"%@",person);
        }
    }
    sqlite3_finalize(stmt);
}

//FMDB
- (void)openFmdb{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).lastObject stringByAppendingPathComponent:@"lperson.db"];
    //打开数据之前先清空旧的数据库
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:filePath error:nil];
    //打开数据库
    databse = [FMDatabase databaseWithPath:filePath];
    //判断是否成功打开数据库
    if (![databse open]){
        NSLog(@"打开数据库失败");
    }
}
- (void)chuangjianbiaoge{
    
    [databse executeUpdate:@"CREATE TABLE IF NOT EXISTS t_person(id integer primary key autoincrement,name text,age integer)"];

}
- (void)charushuju{
    
    [databse beginTransaction];//开始事务
    [databse executeUpdate:@"INSERT INTO t_person(name,age) VALUES(?,?)", @"laowang",[NSNumber numberWithInteger:56]];
    [databse commit];//结束事务
}
- (void)chaxunshiwu{
    
    FMResultSet *requestSet = [databse executeQuery:@"SELECT * FROM t_person"];
    while([requestSet next]){
        NSString *name = [requestSet stringForColumn:@"name"];
        NSInteger age = [requestSet intForColumn:@"age"];
        Student *stu = [[Student alloc] init];
        stu.name = name;
        stu.age = age;
        NSLog(@"stu == %@",stu);
    }
    [requestSet close];
}
//5线程安全,全部
- (void)xianchenganquanFMDB{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).lastObject stringByAppendingPathComponent:@"lperson.db"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    //
    [queue inDatabase:^(FMDatabase *database){
        [database executeUpdate:@"CREATE TABLE IF NOT EXIST t_person(id integer autoincrements,name text ,age integer)"];
        [database executeUpdate:@"INSERT INTO t_person(name,age) VALUE('laozhang',?)",[NSNumber numberWithInteger:35]];
         FMResultSet *result = [database executeQuery:@"select * from t_person"];
         while([result next]) {
         }  
         }];
    //
    [queue inTransaction:^(FMDatabase *database, BOOL *rollback) {
        [database executeUpdate:@"INSERT INTO t_person(name, age) VALUES (?, ?)", @"Bourne_1", [NSNumber numberWithInt:1]];
        [database executeUpdate:@"INSERT INTO t_person(name, age) VALUES (?, ?)", @"Bourne_2", [NSNumber numberWithInt:2]];
        [database executeUpdate:@"INSERT INTO t_person(name, age) VALUES (?, ?)", @"Bourne_3", [NSNumber numberWithInt:3]];
        FMResultSet *result = [database executeQuery:@"select * from t_person"];
        while([result next]) {
        }
        //回滚
        *rollback = YES;//没commit之前，回滚数据
    }];
}

@end
