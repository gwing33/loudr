# Project API
-------

- **GET** `/user/:user_id/project`
- **GET** `/user/:user_id/project/:id`
- **POST** `/user/:user_id/project`
- **PUT** `/user/:user_id/project/:id`
- **DEL** `/user/:user_id/project/:id`

## Get All Projects
-------

**GET** `/user/:user_id/project`

Returns a list of all Projects for a User.
A single user shouldn't have enough to warrent the need of paging

### Response Structure

```
{
  success: true,
  projects: [
    {
      name: '',
      _id: ObjectId,
      __v: 0,
      info: [Object],
      disabled: false,
      api: [Object],
      users: [Object]
    },
    ...
  ]
}
```

## Get Project By ID
-------

**GET** `/user/:user_id/project/:id`

Return a single Project.

### Response Structure

```
{
  success: true,
  project: [
    {
      name: '',
      _id: ObjectId,
      __v: 0,
      info: [Object],
      disabled: false,
      api: [Object],
      users: [Object]
    },
    ...
  ]
}
```

## Create Project
-------

**POST** `/user/:user_id/project`

Creates and returns the project.

### Arguments
##### Required
- **name**: String

##### Optional
- **is_secure**: Boolean

### Response Structure

```
{
  success: true,
  project: [
    {
      name: '',
      _id: ObjectId,
      __v: 0,
      info: [Object],
      disabled: false,
      api: [Object],
      users: [Object]
    },
    ...
  ]
}
```

## Update Project
-------

**PUT** `/user/:user_id/project/:id`

Update and return updated Project.

### Arguments
##### Optional
- **name**: String
- **disabled**: Boolean
- **is_secure**: Boolean
- **emails**: Comma seperated string of emails

### Response Structure

```
{
  success: true,
  project: [
    {
      name: '',
      _id: ObjectId,
      __v: 0,
      info: [Object],
      disabled: false,
      api: [Object],
      users: [Object]
    },
    ...
  ]
}
```

## Delete Project
-------

**DEL** `/user/:user_id/project/:id`

Delete a Project

### Response Structure

```
{ success: true }
```
