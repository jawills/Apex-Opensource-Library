/**
* MIT License
*
* Copyright (c) 2018 Piotr Kożuchowski
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
@IsTest(IsParallel=true)
private class DMLOptionsBuilderTest {

    @IsTest
    static void testBuilder() {
        Database.DMLOptions options = new DMLOptionsBuilder()
            .allOrNone(true)
            .allowDuplicates(true)
            .allowFieldTruncation(true)
            .runDuplicateRulesAsCurrentUser(true)
            .assignmentRuleID(DatabaseService.getFakeId(AssignmentRule.getSObjectType()))
            .useDefaultAssignmentRule()
            .triggerAutoResponseEmail(true)
            .triggerUserEmail(true)
            .triggerOtherEmail(true)
            .localeOptions('pl_PL')
            .build();

        Assert.areEqual(true, options.optAllOrNone);
        Assert.areEqual(true, options.duplicateRuleHeader.allowSave);
        Assert.areEqual(true, options.duplicateRuleHeader.runAsCurrentUser);
        Assert.areEqual(true, options.assignmentRuleHeader.useDefaultRule);
        Assert.areEqual(true, options.assignmentRuleHeader.useDefaultRule);
        Assert.areEqual(true, options.emailHeader.triggerAutoResponseEmail);
        Assert.areEqual(true, options.emailHeader.triggerOtherEmail);
        Assert.areEqual(true, options.emailHeader.triggerUserEmail);
        Assert.areEqual('pl_PL', options.localeOptions);
    }
}