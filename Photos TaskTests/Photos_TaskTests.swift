//
//  Photos_TaskTests.swift
//  Photos TaskTests
//
//  Created by Walid Ahmed on 04/04/2023.
//

import XCTest
import RxSwift
@testable import Photos_Task

class PhotosViewModelTests: XCTestCase {

    var viewModel: PhotosViewModel!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        viewModel = PhotosViewModel()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        disposeBag = nil
        viewModel = nil
        super.tearDown()
    }

    func testGetPhotos_Success() {
        // Given
        let photosExpectation = expectation(description: "Photos loaded successfully")
        var photos: [Photos] = []
        viewModel.isSuccess.asObservable().subscribe(onNext: { success in
            if success {
                photos = self.viewModel.photos.value
                photosExpectation.fulfill()
            }
        }).disposed(by: disposeBag)

        // When
        viewModel.getPhotos()

        // Then
        wait(for: [photosExpectation], timeout: 5)
        XCTAssertTrue(photos.count > 0)
    }

    func testGetPhotos_NoInternetConnection() {
        // Given
        let photosExpectation = expectation(description: "Cached photos loaded due to no internet connection")
        viewModel.isSuccess.asObservable().subscribe(onNext: { success in
            if success {
                photosExpectation.fulfill()
            }
        }).disposed(by: disposeBag)

        // When
        viewModel.isLoading.accept(false)
        viewModel.error.onNext(NetworkError.noInternetConnection)
        viewModel.getPhotos()

        // Then
        wait(for: [photosExpectation], timeout: 5)
        XCTAssertTrue(viewModel.photos.value.count > 0)
    }

    func testLoadNextPageTrigger_Success() {
        // Given
        let photosExpectation = expectation(description: "Photos loaded successfully")
        var photos: [Photos] = []
        viewModel.isSuccess.asObservable().subscribe(onNext: { success in
            if success {
                photos = self.viewModel.photos.value
                photosExpectation.fulfill()
            }
        }).disposed(by: disposeBag)

        // When
        viewModel.loadNextPageTrigger.onNext(())
        viewModel.getPhotos()

        // Then
        wait(for: [photosExpectation], timeout: 5)
        XCTAssertTrue(photos.count > 0)
    }

    func testSaveCachedPhotos() {
        // Given
        let photos = [Photos(id: "1", downloadURL: "url"), Photos(id: "2", downloadURL: "url")]
        viewModel.photos.accept(photos)

        // When
        viewModel.saveCachedPhotos()

        // Then
        let cachedPhotos = PreferenceManager.getCachedPhotos()
        XCTAssertEqual(cachedPhotos.count, 2)
        XCTAssertEqual(cachedPhotos.first?.id, "1")
        XCTAssertEqual(cachedPhotos.last?.id, "2")
    }

}

