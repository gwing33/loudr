## Users

* **GET** /user/:email
* **POST** /user
* **PUT** /user/:id
* **DEL** /user/:id

```
{
  _id: @._id,
  email: @.email,
  name: {
    first: @name.first,
    last: @name.last,
    full: @.name.full
  },
  loginAttempts: @.loginAttempts,
  locked: @.locked
}
```