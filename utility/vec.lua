local classic = Sc.classic
local Vec = classic.class('Vec')

-- 初始化方法，接受数字或原生Vector对象
function Vec:_init(...)
    local args = { ... }
    if #args == 1 and type(args[1]) == 'userdata' and getmetatable(args[1]) == Vector then
        self.entity = args[1]
    elseif #args == 3 and type(args[1]) == 'number' and type(args[2]) == 'number' and type(args[3]) == 'number' then
        self.entity = Vector(args[1], args[2], args[3])
    elseif #args == 1 and args[1].x then
        self.entity = Vector(args[1].x, args[1].y, args[1].z)
    else
        error("Invalid arguments provided to Vec constructor.")
    end
end

--- __add           [重载加法操作符]
-- @param other: Vec (包装后的向量对象)
-- @return Vec (包装后的向量对象)
function Vec:__add(other)
    return Vec(self.entity + other.entity)
end

--- __sub           [重载减法操作符]
-- @param other: Vec (包装后的向量对象)
-- @return Vec (包装后的向量对象)
function Vec:__sub(other)
    return Vec(self.entity - other.entity)
end

--- __mul           [重载乘法操作符，用于向量与标量相乘]
-- @param scalar: number (标量值)
-- @return Vec (包装后的向量对象)
function Vec:__mul(scalar)
    return Vec(self.entity * scalar)
end

--- __div           [重载除法操作符，用于向量与标量相除]
-- @param scalar: number (标量值)
-- @return Vec (包装后的向量对象)
function Vec:__div(scalar)
    return Vec(self.entity / scalar)
end

--- __unm           [重载取负操作符，用于向量取负]
-- @return Vec (包装后的向量对象)
function Vec:__unm()
    return Vec(-self.entity)
end

--- __eq            [比较两个向量是否相等]
-- @param other: Vec (包装后的向量对象)
-- @return boolean (两个向量是否相等)
function Vec:__eq(other)
    return self.entity == other.entity
end

--- __lt            [比较两个向量的长度是否小于]
-- @param other: Vec (包装后的向量对象)
-- @return boolean (当前向量的长度是否小于另一个向量的长度)
function Vec:__lt(other)
    return self.entity:Length() < other.entity:Length()
end

--- __le            [比较两个向量的长度是否小于或等于]
-- @param other: Vec (包装后的向量对象)
-- @return boolean (当前向量的长度是否小于或等于另一个向量的长度)
function Vec:__le(other)
    return self.entity:Length() <= other.entity:Length()
end

--- Lerp            [在两个向量之间插值]
-- @param vecB: Vec (包装后的向量对象)
-- @param t: number (插值参数，范围：0 - 1)
-- @return Vec (包装后的向量对象)
function Vec:Lerp(vecB, t)
    return Vec(self.entity:Lerp(vecB.entity, t))
end

--- Angle           [计算两个向量之间的角度]
-- @param vecB: Vec (包装后的向量对象)
-- @return number (两个向量之间的角度)
function Vec:Angle(vecB)
    return self.entity:Angle(vecB.entity)
end

--- Rotated         [将向量旋转指定角度]
-- @param angle: number (旋转角度)
-- @return Vec (包装后的向量对象)
function Vec:Rotated(angle)
    return Vec(self.entity:Rotated(angle))
end

--- Length          [计算向量的长度]
-- @return number (向量的长度)
function Vec:Length()
    return self.entity:Length()
end

--- Length2D        [计算向量的2D长度]
-- @return number (向量的2D长度)
function Vec:Length2D()
    return self.entity:Length2D()
end

--- Normalized      [返回规范化的向量(单位向量)]
-- @return Vec (包装后的单位向量对象)
function Vec:Normalized()
    return Vec(self.entity:Normalized())
end

--- Dot             [计算两个向量的点积]
-- @param other: Vec (包装后的向量对象)
-- @return number (两个向量的点积)
function Vec:Dot(other)
    return self.entity:Dot(other.entity)
end

--- Cross           [计算两个向量的叉积]
-- @param other: Vec (包装后的向量对象)
-- @return Vec (包装后的向量对象)
function Vec:Cross(other)
    return Vec(self.entity:Cross(other.entity))
end

--- Distance        [计算两个向量之间的距离]
-- @param other: Vec (包装后的向量对象)
-- @return number (两个向量之间的距离)
function Vec:Distance(other)
    return (self.entity - other.entity):Length()
end

--- Distance2D      [计算两个向量在2D平面上的距离]
-- @param other: Vec (包装后的向量对象)
-- @return number (两个向量在2D平面上的距离)
function Vec:Distance2D(other)
    return (self.entity - other.entity):Length2D()
end

--- DirectionTo     [计算从一个向量指向另一个向量的方向向量]
-- @param other: Vec (包装后的向量对象)
-- @return Vec (包装后的方向向量对象)
function Vec:DirectionTo(other)
    local delta = other.entity - self.entity
    return Vec(delta:Normalized())
end

--- __tostring      [重载向量对象的字符串表示]
-- @return string (向量对象的字符串表示)
function Vec:__tostring()
    return string.format("Vec(%f, %f, %f)", self.entity.x, self.entity.y, self.entity.z)
end

--- __index         [重载向量对象的索引操作符]
-- @param key: string (索引键)
-- @return any (索引值)
function Vec:__index(key)
    local indexToKey = { [1] = "x", [2] = "y", [3] = "z" }
    local propertyName = indexToKey[key] or key
    if propertyName == "x" or propertyName == "y" or propertyName == "z" then
        return self.entity[propertyName]
    else
        return Vec[key]
    end
end

return Vec
