function Person(name) {
    if (new.target === Person) {
        this.name = name;   /* using new */
    } else {
        throw new Error('You must use new with Person.')
    }
}

function AnotherPerson(name) {
    Person.call(this, name);
}

var person = new Person('Colin'); /* error, why? */
console.log(person.name);
//var anotherPerson = new AnotherPerson('Nicholas'); /* error */


