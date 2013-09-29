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

TODO: Paging

TODO: Limit number of notifications returned

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
      name: [Object] 
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
    name: [Object] 
  }
}
```

## Create Fan
-------

**POST** `/project/:project_id/fan`

Creates and returns the fan.

TODO: Add in Full Name ability

### Arguments
##### Required
- **email**: String

##### Optional
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
    name: [Object] 
  }
}
```

## Update Fan
-------

**PUT** `/project/:project_id/fan/:fan_handle`

Update and return updated Fan.

TODO: Add in Full Name ability

### Arguments
##### Optional
- **email**: String
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
    name: [Object] 
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
