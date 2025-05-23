/**
* MIT License
*
* Copyright (c) 2019 Piotr Kożuchowski
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

/**
 * Selector Layer class for Permission Sets. Records are queried only once and cached to minimize SOQL limits usage.
 * @see PermissionSetQueryTest
 */
public inherited sharing class PermissionSetQuery extends QueryObject {


    public PermissionSetQuery() {
        super(new List<SObjectField>{
            PermissionSet.Id,
            PermissionSet.Name
        }, PermissionSet.SObjectType);
    }


    /**
     * Filter Permission Set by given name or null if it does not exist.
     */
    public PermissionSetQuery byName(String name) {
        return byName(new Set<String>{name});
    }

    /**
     * Filter Permission Set by given name or null if it does not exist.
     */
    public PermissionSetQuery byName(Set<String> names) {
        return (PermissionSetQuery) byField(PermissionSet.Name, 'IN', names);
    }
}