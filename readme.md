# Network on Chip

## 此工程是复微杯的比赛项目，旨在实现一个基于FPGA的多节点片上互联网络。

## 实现的功能：
### 1、可以配置任意x*y的网络结构，以及任意数量的虚拟通道和缓存Fifo深度、和任意的数据位宽。
### 2、允许用户自定义帧头帧尾的数据格式（在parameters.v中定义）。NoC中解帧头帧尾部分的逻辑被独立剥离为一个verilog function，用户可以自定义重写解帧头帧尾的逻辑。
### 3、采用了基于Filt的虫洞数据流控制技术。将消息分割成多个Flit逐段传输，每个Flit依次占用路径上的路由器端口，具有更低的时延。
### 4、采用了虚拟通道流控制技术。在同一物理通道上提供多个虚拟通道，通过独立缓冲区和传输机制提高吞吐量和减少死锁。
### 5、路由方式采用混合二维路由方法。当虚拟通道数量大于等于2时，奇数项虚拟通道使用X-Y路由，偶数项虚拟通道使用Y-X路由。这样做的好处时，当源节点和目标节点不为直线时，混合路由将可以产生两条不相交的数据路径，极大程度提升数据吞吐量。
### 6、采用两级仲裁：端口仲裁和虚拟通道仲裁，仲裁方式采用循环优先级仲裁器。

## 本工程代码均由verilog和system verilog编写，可直接导入xilinx工程中。在修改了Noc_parameters.v文件的参数后，运行下面指令生成上层接口的代码：
    python build.py

## 生成的上层接口文件为Noc_connector.v，这是整个Noc网络的top接口，将interface文件夹里的定义文件导入后，在BD中模块如下：
<div style="text-align: center;">
  <img src="image.png" alt="alt text">
</div>

## 参考文献
### 1、https://github.com/taichi-ishitani/tnoc
### 2、Sheng Ma,ZhiyingWang,ZonglinLiu,andNatalie Enright Jerger.Leaving one slot emty:Flitbubbleflowcontrolfortoruscache-coherentNoCs.IEEETransactionsonComputers,64:763-777,March2015.D01:10.1109/tc.2013.2295523.
### 3、V.Puente, C.Izu,R.Beivide,J.A.Gregorio,F.Vallejo,and J.M.Prellezo.The adaptivebubblerouter.JournalofParallelandDistributedComputing,64(9):1180-1208,2001.DOI:10.1006/jpdc.2001.1746.

# Network on Chip

## This project is a competition project of the Fudan Micro Cup, aiming at realizing a multi-node on-chip interconnection network based on FPGAs.

## Realized Functions:
### 1, you can configure any x*y network structure, as well as any number of virtual channels and cache Fifo depth, and any data bit width.
### 2. Allow users to customize the data format of the header and footer (defined in parameters.v). The logic of the header and footer part of the NoC is independently stripped as a verilog function, and users can customize and rewrite the logic of the header and footer.
### 3. Filt-based wormhole data flow control technique is adopted. Split the message into multiple flits and transmit them one by one, each flit occupies the router ports on the path in turn, which has lower latency.
### 4. A virtual channel flow control technique is used. Multiple virtual channels are provided on the same physical channel to improve throughput and reduce deadlocks through independent buffers and transmission mechanisms.
### 5. The routing method adopts hybrid two-dimensional routing method. When the number of virtual channels is greater than or equal to 2, the odd-numbered virtual channels use X-Y routing and the even-numbered virtual channels use Y-X routing. The advantage of this is that when the source node and the target node are not straight lines, the hybrid routing will be able to produce two non-intersecting data paths, which greatly improves the data throughput.
### 6. Two levels of arbitration are used: port arbitration and virtual channel arbitration, and the arbitration method uses a cyclic priority arbiter.

## The project code is written in verilog and system verilog and can be imported directly into a xilinx project. After modifying the parameters of the Noc_parameters.v file, run the following instructions to generate the code for the upper interface:
    python build.py

## The upper interface file generated is Noc_connector.v, which is the top interface for the entire Noc network, and after importing the definition file from the interfaces folder, the module in BD is as follows:
<div style="text-align: center;">
  <img src="image.png" alt="alt text">
</div>

## bibliography
### 1、https://github.com/taichi-ishitani/tnoc
### 2、Sheng Ma,ZhiyingWang,ZonglinLiu,andNatalie Enright Jerger.Leaving one slot emty:Flitbubbleflowcontrolfortoruscache-coherentNoCs.IEEETransactionsonComputers,64:763-777,March2015.D01:10.1109/tc.2013.2295523.
### 3、V.Puente, C.Izu,R.Beivide,J.A.Gregorio,F.Vallejo,and J.M.Prellezo.The adaptivebubblerouter.JournalofParallelandDistributedComputing,64(9):1180-1208,2001.DOI:10.1006/jpdc.2001.1746.

## ##
    created by  : <Xidian University>
    email       : <23011210651@stu.xidian.edu.cn>
    created date: 2024-05-16



