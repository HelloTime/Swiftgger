//
//  OpenAPITagsBuilderTests.swift
//  SwiftggerTests
//
//  Created by Marcin Czachurski on 26.03.2018.
//

import XCTest
@testable import Swiftgger

/**
    Tests for tags (controllers descriptions) part of OpenAPI standard (/tags).

    ```
    "tags" : [
        {
            "name" : "Account",
            "description" : "Controller where we can manage tasks"
        },
        {
            "name" : "Users",
            "description" : "Controller where we can manage users"
        },
        {
            "name" : "Tasks",
            "description" : "Controller where we can manage tasks"
        },
        {
            "name" : "Health",
            "description" : "Controller where we can check health"
        }
    ]
    ```
 */
class OpenAPITagsBuilderTests: XCTestCase {

    func testControllerNameShouldBeTranslatedToOpenAPIDocument() {

        // Arrange.
        let openAPIBuilder = OpenAPIBuilder(
            title: "Title",
            version: "1.0.0",
            description: "Description"
        )
        .add(APIController(name: "ControllerName", description: "ControllerDescription"))

        // Act.
        let openAPIDocument = openAPIBuilder.built()

        // Assert.
        XCTAssertEqual("ControllerName", openAPIDocument.tags![0].name)
    }

    func testControllerDescriptionShouldBeTranslatedToOpenAPIDocument() {

        // Arrange.
        let openAPIBuilder = OpenAPIBuilder(
            title: "Title",
            version: "1.0.0",
            description: "Description"
        )
        .add(APIController(name: "ControllerName", description: "ControllerDescription"))

        // Act.
        let openAPIDocument = openAPIBuilder.built()

        // Assert.
        XCTAssertEqual("ControllerDescription", openAPIDocument.tags![0].description)
    }

    func testControllerLinkUrlShouldBeTranslatedToOpenAPIDocument() {

        // Arrange.
        let openAPIBuilder = OpenAPIBuilder(
            title: "Title",
            version: "1.0.0",
            description: "Description"
        )
        .add(APIController(name: "ControllerName", description: "ControllerDescription",
                                     externalDocs: APILink(url: "http://some.link", description: "LinkDescription")))

        // Act.
        let openAPIDocument = openAPIBuilder.built()

        // Assert.
        XCTAssertEqual("http://some.link", openAPIDocument.tags![0].externalDocs?.url)
    }

    func testControllerLinkDescriptionShouldBeTranslatedToOpenAPIDocument() {

        // Arrange.
        let openAPIBuilder = OpenAPIBuilder(
            title: "Title",
            version: "1.0.0",
            description: "Description"
        )
        .add(APIController(name: "ControllerName", description: "ControllerDescription",
                                     externalDocs: APILink(url: "http://some.link", description: "LinkDescription")))

        // Act.
        let openAPIDocument = openAPIBuilder.built()

        // Assert.
        XCTAssertEqual("LinkDescription", openAPIDocument.tags![0].externalDocs?.description)
    }

    static var allTests = [
        ("testControllerNameShouldBeTranslatedToOpenAPIDocument", testControllerNameShouldBeTranslatedToOpenAPIDocument),
        ("testControllerDescriptionShouldBeTranslatedToOpenAPIDocument", testControllerDescriptionShouldBeTranslatedToOpenAPIDocument),
        ("testControllerLinkUrlShouldBeTranslatedToOpenAPIDocument", testControllerLinkUrlShouldBeTranslatedToOpenAPIDocument),
        ("testControllerLinkDescriptionShouldBeTranslatedToOpenAPIDocument", testControllerLinkDescriptionShouldBeTranslatedToOpenAPIDocument)
    ]
}
