# Fan API
-------

- **GET** `/project/:project_id/fan`
- **GET** `/project/:project_id/fan/:fan_handle`
- **POST** `/project/:project_id/fan`
- **PUT** `/project/:project_id/fan/:fan_handle`
- **DEL** `/project/:project_id/fan/:fan_handle`

## Get All Fans
-------

**GET** `/project/:project_id/fan`

Returns a list of all Fans for a project as well as all their notifications.

### Optional Arguments
- limit: defaults to All Users

### Response Structure

```
{
  success: true,
  fans: [
    {
      project_id: ObjectId,
      email: '',
      _id: ObjectId,
      __v: 0,
      info: {
        registered: Date
        created: Date
        updated: Date
      },
      groups: [String],
      notifications: [ NotificationObject ],
      name: {
        first: '',
        last: ''
      }
    },
    ...
  ]
}
```

## Get Fan By ID
-------

**GET** `/project/:project_id/fan/:fan_handle`

Return a single Fan.

### Response Structure

```
{
  success: true,
  fan: {
    project_id: ObjectId,
    email: '',
    _id: ObjectId,
    __v: 0,
    info: {
      registered: Date
      created: Date
      updated: Date
    },
    groups: [String],
    notifications: [ NotificationObject ],
    name: {
      first: '',
      last: ''
    }
  }
}
```

## Create Fan
-------

**POST** `/project/:project_id/fan`

Creates and returns the fan.

### Arguments
##### Required
- **email**: String

##### Optional
- **full_name**: String (will auto convert to first_name and last_name name)
- **first_name**: String
- **last_name**: String
- **fan_groups**: Comma seperated String
- **registered_date**: Date

### Response Structure

```
{
  success: true,
  fan: {
    project_id: ObjectId,
    email: '',
    _id: ObjectId,
    __v: 0,
    info: {
      registered: Date
      created: Date
      updated: Date
    },
    groups: [String],
    notifications: [ NotificationObject ],
    name: {
      first: '',
      last: ''
    }
  }
}
```

## Update Fan
-------

**PUT** `/project/:project_id/fan/:fan_handle`

Update and return updated Fan.

### Arguments
##### Optional
- **email**: String
- **full_name**: String (will auto convert to first_name and last_name name)
- **first_name**: String
- **last_name**: String
- **fan_groups**: Comma seperated String
- **registered_date**: Date

### Response Structure

```
{
  success: true,
  fan: {
    project_id: ObjectId,
    email: '',
    _id: ObjectId,
    __v: 0,
    info: {
      registered: Date
      created: Date
      updated: Date
    },
    groups: [String],
    notifications: [ NotificationObject ],
    name: {
      first: '',
      last: ''
    }
  }
}
```

## Delete F:an
-------

**DEL** `/project/:project_id/fan/:fan_handle`

Delete a Fan

### Response Structure

```
{ success: true }
```
