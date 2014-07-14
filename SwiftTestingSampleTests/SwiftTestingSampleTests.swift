//
//  SwiftTestingSampleTests.swift
//  SwiftTestingSampleTests
//
//  Created by haranicle on 2014/07/11.
//  Copyright (c) 2014年 haranicle. All rights reserved.
//

import UIKit
import XCTest

class SwiftTestingSampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // 2バイト文字をメソッド名に使えるので、テストメソッド名が素敵にできる。
    // 相変わらず頭にtestが必要だけど...
    
    func test_2x3が6になること() {
        // メソッド名に試験観点をかけるのでmessageは特にセットしなくてもいいよね。
        
        // XCTAssertEqual(2 * 3, 6, __FUNCTION__)
        XCTAssertEqual(2 * 3, 6)
    }
    
    /* ==========
    メモ: 特殊リテラル
    __COLUMN__
    __FILE__
    __FUNCTION__
    __LINE__
    
    via http://oropon.hatenablog.com/entry/2014/06/05/030620
    ========== */
    
    func test_文字列比較が正しくできること() {
        // XCTAssertEqualObjectsじゃなくてXCTAssertEqualで比較できるようになった。
        
        // XCTAssertEqualObjects(@"", @"");
        // XCTAssert("aaa" == "aaa")
        XCTAssertEqual("あいう" + "えお", "あいうえお", __FUNCTION__) // !?
    }
    
    func test_配列を正しく比較できること()
    {
        XCTAssertEqual(["いち", "に", "さん"], ["いち", "に", "さん"], __FUNCTION__)
    }
    
    func test_generateIdが期待通りの挙動であること() {
        let item:Item = Item(title:"えんぴつ", price:120, type:"文房具")
        
        XCTAssertEqual(item.generateId(), "id-文房具-えんぴつ", __FUNCTION__)
    }
    
    func test_何かの処理の結果得られたItemが期待通りであること() {
        // Item.swiftのTarget Membershipで、Testsのターゲットにチェックを入れるだけでItemクラスを扱える。
        // importとかは必要ない。
        
        // 何かの処理で得られたItem
        let item:Item = Item(title:"えんぴつ", price:120, type:"文房具")
        
        let expectedItem:Item = Item(title:"えんぴつ", price:120, type:"文房具")
        
        XCTAssert(item.isEqual(expectedItem))
        //XCTAssertEqualObjects(item, expectedItem, __FUNCTION__)
    }
    
    func test_パフォーマンスのテスト() {
        // measureBlock内のパフォーマンスを測定することができる。
        // 10回実行して、平均の時間を測定してくれる。
        // テスト実行後に <Time: x.xx sec ...　と書いてるところをクリックすると
        // BaseLineなどを設定できる。
        
        var count:Int = 0;
        self.measureBlock() {
            println("パフォーマンス\(++count)")
            NSThread.sleepForTimeInterval(1.0)
        }
    }
    
    // 非同期のテストもできるようになったけど　TRVSMonitor　と同じ?
    // via http://qiita.com/asakahara/items/39abb8aa08544223ecd4
    
    func test_非同期のテスト() {
        let expectation:XCTestExpectation = self.expectationWithDescription(__FUNCTION__)
        
        // なにか非同期の処理
        dispatch_async(dispatch_get_main_queue(), {
            
            NSThread.sleepForTimeInterval(3)
            
            println("非同期おわった")
            
            // 処理が終わった時にこれをする。
            expectation.fulfill()
            })
        
        println("待ち始めた")
        
        // ここまで来たら、fulfillが呼ばれるまで待つ
        // タイムアウトを設定できる。
        self.waitForExpectationsWithTimeout(3 , handler: nil)
        
        println("全部おわった")
    }
    
}
