# Users
-------

- **GET** `/user`
- **GET** `/user/:id`
- **POST** `/user`
- **PUT** `/user/:id`
- **DEL** `/user/:id`

## Get All Users
-------

**GET** `/user`

Returns a list of all Loudr Users.

**TODO:** Add Pagination at some point.

### Response Structure

```
{
  success: true,
  users: [
    {
      email: '',
      password: '',
      _id: ObjectId,
      __v: 0,
      permissions: [],
      is_super: false,
      locked: false,
      loginAttempts: 0,
      name: {
        first: '',
        last: ''
      }
    },
    ...
  ]
}
```

## Get User By ID
-------

**GET** `/user/:id`

Return a single Loudr User.

### Response Structure

```
{
  success: true,
  user: {
    email: '',
    password: '',
    _id: ObjectId,
    __v: 0,
    permissions: [],
    is_super: false,
    locked: false,
    loginAttempts: 0,
    name: {
      first: '',
      last: ''
    }
  }
}
```

## Create Loudr User
-------

**POST** `/user`

Creates and returns the Loudr User.

### Arguments
##### Required
- **email**: Must be a valid email
- **password**: Currently no password requirements

##### Optional
- **full_name**: Will parse out the first and last name
  - **first_name**: Optionally you can individually pass in just the first name
  - **last_name**: Optionally you can individually pass in just the last name

### Response Structure

```
{
  success: true,
  user: {
    email: '',
    password: '',
    _id: ObjectId,
    __v: 0,
    permissions: [],
    is_super: false,
    locked: false,
    loginAttempts: 0,
    name: {
      first: '',
      last: ''
    }
  }
}
```

## Update Loudr User
-------

**PUT** `/user/:id`

Update and return updated Loudr User.

### Arguments
##### Optional
- **new_password**: Currently no password requirements
  - **password**: Current password **required** if `new_password` is passed in
- **full_name**: Will parse out the first and last name
  - **first_name**: Optionally you can individually pass in just the first name
  - **last_name**: Optionally you can individually pass in just the last name

### Response Structure

```
{
  success: true,
  user: {
    email: '',
    password: '',
    _id: ObjectId,
    __v: 0,
    permissions: [],
    is_super: false,
    locked: false,
    loginAttempts: 0,
    name: {
      first: '',
      last: ''
    }
  }
}
```

## Delete Loudr User
-------

**DEL** `/user/:id`

Delete a Loudr User

### Response Structure

```
{ success: true }
```