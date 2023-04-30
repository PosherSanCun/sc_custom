local classic = Sc.classic

local Base = classic.class('Base')

--检查是否为对象
local function isEntity(variable)
    return type(variable) == 'table' and getmetatable(variable) ~= nil and getmetatable(variable).__index ~= nil and
        type(getmetatable(variable).__index.GetAbsOrigin) == 'function'
end

--判定属于向量
local function isVector(variable)
    if type(variable) == 'table' and variable.x ~= nil and variable.y ~= nil and variable.z ~= nil then
        return true
    else
        return false
    end
end

function Base:_init(entity)
    self.entity = assert(entity) -- 存储原生实体对象
    print(self.entity)
end

function Base:getEntity()
    return self.entity -- 获取原生实体对象
end

function Base:__index(key)
    -- 检查原生实体对象是否存在该属性或方法
    local entityValue = rawget(self, "entity")
    if entityValue and entityValue[key] ~= nil then
        return entityValue[key]
    end

    -- 否则返回 nil
    return nil
end

function Base:__newindex(key, value)
    -- 检查原生实体对象是否存在该属性或方法
    if self.entity and self.entity[key] ~= nil then
        self.entity[key] = value
    else
        -- 否则将该属性或方法添加到 Base 实例中
        rawset(self, key, value)
    end
end

-- 静态方法，用于检查实体对象是否为指定类型
function Base.static.isType(entity, typeName)
    --判定属于实体
    if not isEntity(entity) then
        return false
    end
    if not (typeName and type(typeName) ~= 'string') then
        return
    end

    if typeName == "Vector" or typeName == "Vec" then
        return isVector(entity)
    end
    -- 获取实体对象的类名
    local className
    if entity.GetClassname then
        className = entity:GetClassname()
    end

    -- 判断实体对象的类名,当类名是是其父类时，也返回true
    return string.find(className, typeName) and true
end

-- 静态方法，用于检查实体对象是否为原生类
function Base.static.isNative(entity)
    -- 获取实体对象的元表
    local metaTable = getmetatable(entity)

    -- 判断元表是否为原生类的元表
    return metaTable == CBaseEntity.__index
end

return Base
