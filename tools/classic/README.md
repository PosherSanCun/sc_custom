
＃ classic

`classic`是Lua的简单类系统。
其功能包括：

 *命名类；允许嵌套名称

 *不污染全局名称空间

 *与torch.save / torch.load兼容

 *反射

 *'fat'继承，mixins

 *严格性

 *接口

 *允许两次重复同一定义

## 用法

### 基本用法

```lua
local classic = require 'classic' --

local MyClass = classic.class("MyClass")

function MyClass:_init(opts)
  self.x = opts.x
end

function MyClass:getX()
  return self.x
end

local instance_a = MyClass{x = 3}
local instance_b = MyClass{x = 4}
print(instance_a, instance_a:getX())
print(instance_b, instance_b:getX())
```

### 继承

```lua
local classic = require 'classic'

local Base = classic.class("Base")
function Base:_init()
  self._x = "base"
end

function Base:getX()
  return self._x
end


local Child, super = classic.class("Child", Base)

function Child:_init(y)
  super._init(self) -- 调用超级构造函数, *传入 self*
  self._y = assert(y)
end

function Child:getY()
  return self._y
end

local obj = Child("y")
print(obj:getY()) -- y
print(obj:getX()) -- base
print(obj:class():isSubclassOf(Base)) -- true
```

### 反射

```lua
print(instance_a:class():name())
print(instance_a:class():methods())
```

### Torch IO兼容性

注意：经典类必须使用`classic.torch`才能正常使用torch序列化！

```lua
local classic = require 'classic'
require 'classic.torch'

local A = classic.class("A")
function A:foo()
  return 3
end

local a = A()
torch.save("a.t7", a)
local loaded = torch.load("a.t7")
print(a:foo())
```

在加载`classic.torch`之后，自定义`__read` /`__write`方法现在可以被添加到类中（作为常规方法而不是元方法）。`torch.load`如果存在，`torch.save`将调用这些方法，如`read`/`write`在`torch.class`实例中使用的元方法。

### 严格

```lua
local classic = require 'classic'

local A = classic.class("A")

local a = A()
classic.strict(a)

-- Error!
print(a.thisAttributHasATypo)
```

### 类属性

You can store data on class objects - for example, if you want to share
something between all instances of that class. Note only that you cannot store a
function as a class attribute, as that is indistinguishable from defining an
instance method.

您可以将数据存储在类对象上.例如:如果要共享该类所有实例之间的某些内容。仅注意您不能将函数存储为类属性，因为这与定义实例方法是无法区分的。

```lua
local classic = require 'classic'

local A = classic.class("A")
A.var = 3
print(A.var)
```

### 静态方法


您可以定义静态方法，这些方法与整个类有关，而不是与任何特定实例有关。静态方法在其参数中不接收任何实例或类对象，而是使用`.`进行声明和调用。

```lua
local classic = require 'classic'

local A = classic.class("A")

function A.static.myStaticMethod(x)
  return x
end

print(A.myStaticMethod(3))
```

### 'mustHave' 方法

In classic, marking a method as `mustHave()` in a class will cause an error to
be thrown when that class, or descendants, are instantiated - if the method has
not been implemented. This feature can also be used in mixins.

当定义一个抽象基类时，它依赖于某些方法的存在但不为它们提供任何实现，将这些方法标记为必须由继承类实现是很有用的。

这类似于C ++中的纯虚方法或Java中的接口。

传统上，在类中将方法标记为`mustHave()`会在实例化该类或后代（如果尚未实现该方法）时引发错误。此功能也可以在mixin中使用。

```lua
local classic = require 'classic'

local A = classic.class("A")

A:mustHave("essentialMethod")

function A:getResult()
  return self:essentialMethod() + 1
end

local B = classic.class("B", A)

function B:essentialMethod()
  return 2
end

-- OK: method is implemented.
local b = B()

local C = classic.class("C", A)

-- Error: 'essentialMethod' is marked 'mustHave' but was not implemented.
local c = C()
```

### 'final' 方法

指示特定方法不应被子类覆盖也很有用。 这是通过使用final（）来完成的。

任何尝试覆盖子类中的final方法的尝试都会触发错误。

方法也可以在mixin中标记为final。

您只能在方法定义后将其标记为最终方法。

```lua
local classic = require 'classic'

local A = classic.class("A")

function A:finalMethod()
  print("This should not be meddled with!")
end
A:final("finalMethod")

local B = classic.class("B", A)

-- Error: this override is no longer permitted.
function B:finalMethod()
  print("Attempted meddling!")
end
```

### 元方法

It is possible to define special methods that override certain operators for an
object. Rather than manually setting the metatable, as you would do if you
weren't using classic, you simply define appropriately named methods in your
class.

可以定义特殊方法来覆盖对象的某些运算符。 与其像不使用经典表那样手动设置元表，不如简单地在类中定义适当命名的方法。

```lua

local classic = require 'classic'

local A = classic.class("A")

function A:__index(name)
  -- custom index method
end

function A:__call(arg1, arg2)
  return self[arg1] + arg2
end

-- ...

``` lua
可以通过这种方式设置的元方法包括：

  *`__add`-加法运算符。
  *`__call`-函数调用。
  *`__concat`-串联（`..`）运算符。
  *`__div`-除法运算符。
  *`__index`-关键查找。 （ʻobj [key]`）
  *`__mul`-乘法运算符。
  *`__newindex`-设置对应于键的值。 （ʻobj [key] = x`）
  *`__pow`-求幂运算符。
  *`__sub`-减法运算符。
  *`__tostring`-字符串转换。
  *`__unm`-一元减运算符。
  *`__write`-Torch序列化挂钩。
  *`__read`-Torch序列化挂钩。
```

请参阅相应的Lua / Torch文档，以获取更多详细信息。

### 模块

与类系统一样，经典版也具有定义模块的方式。
**您不必使用模块系统即可使用类系统。**
但是，这可能是组织代码并减少样板的一种干净方法。

它要求您遵守的规则如下：每个类都应在其自己的文件中定义，而文件名决定类的名称。

最好的解释方法是举一个例子。

这是典型的顶级经典模块定义：

```lua
local classic = require 'classic'

local my_project = classic.module(...)
my_project:class("MyClass")
my_project:submodule("utils")
return my_project
```

现在，如果将其保存在“ my_project / init.lua”中，则可以照常通过以下方式加载

```lua
local my_project = require 'my_project'
```

运行代码时，上述模块中的`...`符号
定义将设置为要求名称：“ my_project”。

此模式既可确保正确设置模块名称，又可确保
节省您多次键入的时间。

定义模块时使用的局部变量名称不正确
实际上很重要-因此您同样可以写：

```lua
local classic = require 'classic'

local M = classic.module(...)
M:class("MyClass")
M:submodule("utils")
return M
```

which some may find preferable. With this approach, renaming a module is simply
a matter of renaming the directory that contains it.
有些人可能会觉得这更可取。使用这种方法，重命名模块很简单
一个重命名包含它的目录的问题。

Now, what about these 'class' and 'submodule' calls? These simply outline the
things the module contains. The calls **do not** load the things they refer to;
they just register the fact that they exist. The advantage of this is that
code can use something from a module without having to load the whole thing.
This includes code in the module itself.
那么，这些'类'和'子模块'调用呢?这些简单概括了
模块包含的东西。调用**do not**加载它们引用的东西;
它们只是记录了它们存在的事实。这样做的好处是
代码可以使用模块中的某些内容，而不必加载整个模块。
这包括模块本身中的代码。

So, `M:class("MyClass")` says that `require 'my_project.MyClass'` is going to
return the definition of that class. Similarly `M:submodule("utils")` says that
there is a submodule that can be loaded by calling `require 'my_project.utils'`.

With this in mind, we just need to define the corresponding objects in the right
places - note that we can use the `...` trick again to save writing the full
names everywhere.

In `my_project/MyClass.lua`, we write:

```lua
local MyClass = classic.class(...)
function MyClass:_init(opts)
  self.x = opts.x
end

return MyClass
```

and in `my_project/utils/init.lua`, we write:

```lua
local utils = classic.module(...)
local my_project = require 'my_project'

function utils.makeTestObject()
  return my_project.MyClass{x=3}
end

return utils
```

We could just as well have saved this as `my_project/utils.lua`, but using a
separate subdirectory leaves more opportunity for expanding the utils submodule
without resulting in a single large file.

Note that in the utils submodule, we referred to MyClass by requiring
'my_project', and 'my_project' itself contains 'utils' - but this does not
result in a circular dependency! This is because the declaration of 'utils' in
'my_project' does not cause 'utils' to actually be loaded. Only when somebody
accesses 'my_project.utils' will the definition really be loaded. This pattern
can make things cleaner in large projects.

You can even specify that individual functions should be loaded lazily, if you
want to use this pattern everywhere in a project:

```lua
local utils = classic.module('utils')
utils:moduleFunction('myFunction')
return utils
```

This assumes that `require 'utils.myFunction'` will return the function in
question.

### Adding torch.class instances to classic modules

In module definition:

```lua
MyModule = classic.module(...)  -- note: this is global.

local MyClass = torch.class('MyModule.MyClass')

MyClass:__init(opts)
  self.x = opts.x
end
```

and in client code:

```lua
local my_project = require 'path.to.MyModule'
local obj = my_project.MyClass{x = 1}
```

### 回调

You can register your own functions to be called when classic does various
things. For instance, for debugging purposes you might want to be notified every
time a class is defined.
你可以注册你自己的函数在classic做各种事情的时候被调用。例如，出于调试目的，您可能希望在每次定义类时都得到通知。

```lua
local classic = require 'classic'
classic.addCallback(classic.events.CLASS_INIT, function(name)
  print("A class was defined: ", name)
end)
```

See the table in `classic/init.lua` for the full list of events that you can use
to trigger callbacks, and the details of what the callback functions will be
passed.

