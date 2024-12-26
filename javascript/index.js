/**
 * Creational design pattern
 * 
 * 1. singletone
 */


/**
 * Singleton
 */
class User {
    constructor() {
        if (!User.instance) {
            User.instance = this;
        }
        return User.instance;
    }
}
const a1 = new User()
const a2 = new User();

console.log(a1 === a2)