
import RealmSwift

class Registration: Object {
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var email: String = ""
    @Persisted var password: String = ""
}
