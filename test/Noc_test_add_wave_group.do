# 打开一个新的波形窗口或切换到已有的波形窗口
# wave create

# 添加顶层模块的信号
add wave -noupdate sim:/Noc_top/*

# 创建接口分组并添加信号
set interfaces [find signals sim:/Noc_top/Noc_fabric_inst/*]
foreach sig $interfaces {
    set sig_name [string trimleft $sig "sim:/Noc_top/Noc_fabric_inst/"]
    add wave -noupdate -group $sig_name $sig
}

# 更新波形窗口
wave update
