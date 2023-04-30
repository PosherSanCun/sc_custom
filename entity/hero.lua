local classic = require 'classic'
local Base = require 'Base'
local Vec = require 'sc_custom.utility.vec'

-- 定义一个新的 Hero 类，继承自 Base 类
local Hero = classic.extend(Base, 'Hero')

-- 构造函数，接收一个英雄实体对象
function Hero:_init(hero)
    -- 调用父类的构造函数，保存英雄实体对象
    Hero.super._init(self, hero)
end

-- 获取英雄等级
function Hero:getLevel()
    return self.entity:GetLevel()
end

-- 设置英雄等级
function Hero:setLevel(level)
    self.entity:SetLevel(level)
end

-- 获取英雄位置
function Hero:getPosition()
    -- 调用英雄实体的 GetAbsOrigin 方法，返回向量类型的位置信息
    return Vec(self.entity:GetAbsOrigin())
end

-- 设置英雄位置
--@param position Vec类型的位置信息(兼容原生实体或框架实体)
function Hero:setPosition(position)
    if not Base.isType(position, 'Vec') then
        error('position is not a Vec')
        return false
    end
    position = position.entity or position
    -- 调用英雄实体的 SetAbsOrigin 方法，设置英雄位置
    self.entity:SetAbsOrigin(position)
end

-- 添加其它英雄特有的方法和属性

return Hero
