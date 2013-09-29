# Fan Notification API
-------

- **GET** `/project/:project_id/fan/:fan_handle/note`
- **GET** `/project/:project_id/fan/:fan_handle/note/:id`
- **POST** `/project/:project_id/fan/:fan_handle/note`
- **PUT** `/project/:project_id/fan/:fan_handle/note/:id`
- **DEL** `/project/:project_id/fan/:fan_handle/note/:id`

## Get All Fan Notifications
-------
**GET** `/project/:project_id/fan/:fan_handle/note`

Returns a list of all Fan Notifications for a project.

TODO: Paging

TODO: Limit number of notifications returned

TODO: Define interacted, Seen, Format and Kind

### Response Structure

```
{
  success: true,
  notifications: [
    {
      _id: ObjectId,
      text: '',
      url: '',
      updated: Date,
      created: Date,
      dissmissed: false,
      interacted: 0,
      seen: 0,
      format: 0,
      kind: 0
    },
    ...
  ]
}
```

## Get Fan Notification By ID
-------

**GET** `/project/:project_id/fan/:fan_handle/note/:id`

Return a single Fan Notification.

### Response Structure

```
{
  success: true,
  notification: {
    _id: ObjectId,
    text: '',
    url: '',
    updated: Date,
    created: Date,
    dissmissed: false,
    interacted: 0,
    seen: 0,
    format: 0,
    kind: 0
  }
}
```

## Create Fan Notification
-------

**POST** `/project/:project_id/fan/:fan_handle/note`

Creates and returns the fan notification.

TODO: Should require HTML or Text.

### Arguments
##### Optional
- **html**: String
- **text**: String
- **url**: String

### Response Structure

```
{
  success: true,
  notification: {
    _id: ObjectId,
    text: '',
    url: '',
    updated: Date,
    created: Date,
    dissmissed: false,
    interacted: 0,
    seen: 0,
    format: 0,
    kind: 0
  }
}
```

## Update Fan Notification
-------

**PUT** `/project/:project_id/fan/:fan_handle/note/:id`

Update and return updated Fan Notification.

### Arguments
##### Optional
- **html**: String
- **text**: String
- **url**: String
- **kind**: int
- **format**: int
- **seen**: int
- **interacted**: int
- **dissmissed**: int

### Response Structure

```
{
  success: true,
  notification: {
    _id: ObjectId,
    text: '',
    url: '',
    updated: Date,
    created: Date,
    dissmissed: false,
    interacted: 0,
    seen: 0,
    format: 0,
    kind: 0
  }
}
```

## Delete F:an
-------

**DEL** `/project/:project_id/fan/:fan_handle/note/:id`

Delete a Fan Notification

### Response Structure

```
{ success: true }
```