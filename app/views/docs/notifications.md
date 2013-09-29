# Fan Notification API
-------

- **GET** `/project/:project_id/fan/:fan_handle/note`
- **GET** `/project/:project_id/fan/:fan_handle/note/:id`
- **POST** `/project/:project_id/fan/:fan_handle/note`
- **PUT** `/project/:project_id/fan/:fan_handle/note/:id`
- **DEL** `/project/:project_id/fan/:fan_handle/note/:id`

## Notification Object

- **dissmissed**: Number of times they dismissed the note
- **interacted**: Number of times they clicked on the note
- **seen**: Number of times they saw the note
- **format**: Int; 0 denotes HTML, 1 denotes Text, everything else is user application based
- **kind**: Int; Type of notification. 0 = General, 1 = Maintenance, 2 = Alert

```
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
}
```

## Get All Fan Notifications
-------
**GET** `/project/:project_id/fan/:fan_handle/note`

Returns a list of all Fan Notifications for a project.

### Arguments
##### Optional
- **limit**: int (default: 10)
- **page**: int (default: 1)

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

### Arguments
##### Required
- html, text or url: One of them must be included in the creation

##### Optional
- **html**: String
- **text**: String
- **url**: String
- **format**: Int (Or will default to html and text)

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