**Dota2 实体包装框架**

这是一个正在开发中的项目，旨在为 Dota 2 插件和自定义游戏开发提供一个更易于使用和维护的框架。我们使用 Lua 语言和 Dota 2 的原生 API 开发了这个框架，并将其开源以便于更多人参与开发和贡献。

我们的目标是创建一个高效、灵活和易用的实体包装框架，可以让开发者更专注于业务逻辑的实现而不必处理 Dota 2 API 的底层细节。我们已经实现了多个类别的实体包装器，如英雄、技能、物品、单位和建筑等，并在不断完善和扩展这个框架的功能。

我们希望更多的开发者加入我们的行列，共同参与这个项目的开发和维护。无论你是新手还是资深开发者，你都可以在这个项目中找到自己的位置，学习和分享经验，并为 Dota 2 的插件和自定义游戏开发做出贡献。

一起来参与这个项目吧！👏🎉

# 自定义 Dota 2 框架

此框架旨在为 Dota 2 实体提供一套自定义类，简化与游戏 API 的交互。

## 目录结构

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

## 类层次结构

1. **基类（Base）**

   - 构造函数：接收原生实体对象并保存
   - 获取原生实体对象的方法
   - 重载索引操作符：允许访问原生实体对象的方法和属性

2. **英雄类（Hero）**

   - 继承自 Base
   - 包装英雄特有的方法和属性，例如：
     - 获取/设置等级
     - 获取/设置经验
     - 获取/设置金钱
     - 添加/移除/升级技能

3. **技能类（Ability）**

   - 继承自 Base
   - 包装技能特有的方法和属性，例如：
     - 获取/设置技能等级
     - 获取技能施法距离
     - 获取技能冷却时间
     - 施放技能

4. **物品类（Item）**

   - 继承自 Base
   - 包装物品特有的方法和属性，例如：
     - 获取物品名称
     - 获取物品持有者
     - 使用物品
     - 出售/丢弃物品

5. **单位类（Unit）**

   - 继承自 Base
   - 包装单位特有的方法和属性，例如：
     - 获取/设置生命值
     - 获取/设置魔法值
     - 获取/设置攻击力
     - 获取/设置护甲值
     - 添加/移除状态效果

6. **建筑类（Building）**

   - 继承自 Base
   - 包装建筑特有的方法和属性，例如：
     - 获取建筑类型（如兵营、哨塔等）
     - 获取/设置生命值
     - 获取/设置护甲值
     - 添加/移除状态效果

7. **工具类（Tools）**
   - 向量类(Vec)
   - 计时器类(Timer)

## 项目入口

提供一个初始化函数，用于将原生实体对象包装为相应的包装类对象。

## 安装

1.将整个文件放置在\dota 2 beta\game\dota_addons\new3\scripts\vscripts\目录下

2.然后在 addon_game_mode.lua 中添加：

```lua
    require 'sc_custom._init'
```

## 测试示例

```lua
    Debug = Debug or class({})

    function Debug:init()
        ListenToGameEvent("player_chat", Dynamic_Wrap(Debug, "on_player_chat"), self)   --注册玩家聊天回调
    end

    function Debug:on_player_chat(event)
        local unit = Sc.Hero(player:GetAssignedHero())  -- 包装英雄 这一步通常会用事件触发
        print(unit)                                     -- 对__String方法的重载
        print(unit:GetName())                           -- 定义自定义方法
        print(unit:GetUnitName())                       -- 仍然可以直接使用原生的方法
    end

    --进入游戏输入任意信息即可看到打印结果
```
