# Customized User Identification
---

By default, the SDK automatically generates a unique ID for the user, which does not have any identifying attributes and can only distinguish between different user attributes.

For this reason we provide an additional API to add different identification attributes to the current user.

| Properties | Type   | Description               |
| ---------- | ------ | ------------------------- |
| user.id    | string | User ID                   |
| user.name  | string | User nickname or username |
| user.email | string | User Email                |

The following attributes are optional, but it is recommended that at least one of them be provided.

### Adding User Identification

=== "CDN Sync"

    ```javascript
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

=== "CDN Async"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.setUser({
            id: '1234',
            name: 'John Doe',
            email: 'john@doe.com',
        })
    })
    ```

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

### Remove User Identification

=== "CDN Sync"

    ```javascript
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.removeUser()
    ```

=== "CDN Async"

    ```javascript
    DATAFLUX_RUM.onReady(function() {
        DATAFLUX_RUM.removeUser()
    })
    ```

=== "NPM"

    ```javascript
    import { datafluxRum } from '@cloudcare/browser-rum'
    datafluxRum.removeUser()
    ```

