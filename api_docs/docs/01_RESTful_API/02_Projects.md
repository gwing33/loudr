## Projects

* **GET** /project
* **GET** /project/:id
* **POST** /project
* **PUT** /project/:id
* **DEL** /project/:id
* **DEL** /project/confirm/:id
* **DEL** /project/disable/:id
* **GET** /project/enable/:id

```
{
  _id: @_id,
  name: @name,
  api: {
    key: @api.key
  },
  disabled: @disabled,
  users: @users,
  info: @info
}
```