**Dota2 实体包装框架**

这是一个正在开发中的项目，旨在为 Dota 2 插件和自定义游戏开发提供一个更易于使用和维护的框架。我们使用 Lua 语言和 Dota 2 的原生 API 开发了这个框架，并将其开源以便于更多人参与开发和贡献。

我们的目标是创建一个高效、灵活和易用的实体包装框架，可以让开发者更专注于业务逻辑的实现而不必处理 Dota 2 API 的底层细节。我们已经实现了多个类别的实体包装器，如英雄、技能、物品、单位和建筑等，并在不断完善和扩展这个框架的功能。

我们希望更多的开发者加入我们的行列，共同参与这个项目的开发和维护。无论你是新手还是资深开发者，你都可以在这个项目中找到自己的位置，学习和分享经验，并为 Dota 2 的插件和自定义游戏开发做出贡献。

一起来参与这个项目吧！👏🎉

**Dota2 Entity Wrapper Framework**

This is an ongoing project aimed at providing a more user-friendly and maintainable framework for developing Dota 2 plugins and custom games. We developed this framework using Lua language and Dota 2's native API, and open-sourced it for more people to participate in development and contribute.

Our goal is to create an efficient, flexible, and easy-to-use entity wrapper framework that allows developers to focus on implementing business logic without having to deal with the underlying details of Dota 2 API. We have already implemented entity wrappers for multiple categories such as heroes, abilities, items, units, and buildings, and are constantly improving and expanding the functionality of this framework.

We hope more developers can join us and participate in the development and maintenance of this project. Whether you are a novice or a seasoned developer, you can find your place in this project, learn and share experiences, and contribute to the development of plugins and custom games for Dota 2.

Come join us in this project!👏🎉

框架使用 classic 库实现面向对象编程，使用前需要先导入 classic 库: github 地址:https://github.com/deepmind/classic/blob/master/README.md

```lua
    require 'tools.classic'
```

**1.共通基类（Base）**
构造函数：接收原生实体对象并保存
获取原生实体对象的方法
重载索引操作符：允许访问原生实体对象的方法和属性

**2.英雄类（Hero）**
继承自 Base
包装英雄特有的方法和属性，例如：
获取/设置等级
获取/设置经验
获取/设置金钱
添加/移除/升级技能

**3.技能类（Ability）**
继承自 Base
包装技能特有的方法和属性，例如：
获取/设置技能等级
获取技能施法距离
获取技能冷却时间
施放技能

**4.物品类（Item）**
继承自 Base
包装物品特有的方法和属性，例如：
获取物品名称
获取物品持有者
使用物品
出售/丢弃物品

**5.单位类（Unit）**
继承自 Base
包装单位特有的方法和属性，例如：
获取/设置生命值
获取/设置魔法值
获取/设置攻击力
获取/设置护甲值
添加/移除状态效果

**6.建筑类（Building）**
继承自 Base
包装建筑特有的方法和属性，例如：
获取建筑类型（如兵营、哨塔等）
获取/设置生命值
获取/设置护甲值
添加/移除状态效果

**7.工具类（Tools）**
向量类(Vec)
计时器类(Timer)

**项目入口**

提供一个初始化函数，用于将原生实体对象包装为相应的包装类对象

sc_custom/
│
├── entity/
│ ├── base.lua
│ ├── hero.lua
│ ├── ability.lua
│ ├── item.lua
│ └── ...
│
├── tools/
│ ├──classic/
│ └── ...
│
├── utility/
│ ├── vec.lua
│ ├── timer.lua
│ └── ...
│
└── \_init.lua
