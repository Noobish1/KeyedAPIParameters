import Quick
import Nimble
@testable import KeyedAPIParameters

internal final class DateSpec: QuickSpec {
    internal override func spec() {
        describe("Date") {
            describe("it's timeSince1970InMillis") {
                context("when the timeIntervalSince1970 is 50") {
                    var date: Date!
                    
                    beforeEach {
                        date = Date(timeIntervalSince1970: 50)
                    }
                    
                    it("should return 50000") {
                        expect(date.timeSince1970InMillis) == 50000
                    }
                }
            }
        }
    }
}
