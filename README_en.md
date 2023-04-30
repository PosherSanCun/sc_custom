**Dota2 Entity Wrapper Framework**

This is an ongoing project aimed at providing a more user-friendly and maintainable framework for developing Dota 2 plugins and custom games. We developed this framework using Lua language and Dota 2's native API, and open-sourced it for more people to participate in development and contribute.

Our goal is to create an efficient, flexible, and easy-to-use entity wrapper framework that allows developers to focus on implementing business logic without having to deal with the underlying details of Dota 2 API. We have already implemented entity wrappers for multiple categories such as heroes, abilities, items, units, and buildings, and are constantly improving and expanding the functionality of this framework.

We hope more developers can join us and participate in the development and maintenance of this project. Whether you are a novice or a seasoned developer, you can find your place in this project, learn and share experiences, and contribute to the development of plugins and custom games for Dota 2.

Come join us in this project!👏🎉

框架使用 classic 库实现面向对象编程，使用前需要先导入 classic 库: github 地址:https://github.com/deepmind/classic/blob/master/README.md

```lua
    require 'tools.classic'
```

# Custom Dota 2 Framework

This framework is designed to provide a custom set of classes for working with Dota 2 entities, making it easier to work with the game's API.

## Directory Structure

```
sc_custom/
│
├── entity/
│   ├── base.lua
│   ├── hero.lua
│   ├── ability.lua
│   ├── item.lua
│   └── ...
│
├── tools/
│   ├── classic/
│   └── ...
│
├── utility/
│   ├── vec.lua
│   ├── timer.lua
│   └── ...
│
└── _init.lua
```

## Class Hierarchy

1. **Base Class**

   - Constructor: Accepts and stores a native entity object
   - Method to retrieve the native entity object
   - Overloaded index operator to access native entity object's methods and properties

2. **Hero Class**

   - Inherits from Base
   - Wraps hero-specific methods and properties, such as:
     - Get/Set level
     - Get/Set experience
     - Get/Set gold
     - Add/Remove/Upgrade abilities

3. **Ability Class**

   - Inherits from Base
   - Wraps ability-specific methods and properties, such as:
     - Get/Set ability level
     - Get ability cast range
     - Get ability cooldown
     - Cast ability

4. **Item Class**

   - Inherits from Base
   - Wraps item-specific methods and properties, such as:
     - Get item name
     - Get item owner
     - Use item
     - Sell/Drop item

5. **Unit Class**

   - Inherits from Base
   - Wraps unit-specific methods and properties, such as:
     - Get/Set health
     - Get/Set mana
     - Get/Set attack damage
     - Get/Set armor
     - Add/Remove status effects

6. **Building Class**

   - Inherits from Base
   - Wraps building-specific methods and properties, such as:
     - Get building type (e.g., barracks, tower, etc.)
     - Get/Set health
     - Get/Set armor
     - Add/Remove status effects

7. **Utility Classes**
   - Vector class (Vec)
   - Timer class (Timer)

## Project Entry

Provide an initialization function to wrap native entity objects into the corresponding wrapper class objects.
