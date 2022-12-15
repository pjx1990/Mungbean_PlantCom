#-*- coding: utf-8 -*-
import sys
import argparse
import matplotlib.pyplot as plt

def get_data(openfile,number):
    percent_data = []
    cdf_data = []
    temp_sum = 0
    temp_number = 0
    index = 0

    file = open(openfile,"r")
    for line in file:
        line = line.strip()
        if line == "":
            continue
        each_data = float(line.split("\t")[1])
        percent_data += [each_data]
        cdf_data += [each_data + temp_sum]
        temp_sum += each_data
    
    for i in range(0,percent_data.__len__())[::-1]:
        temp_number += percent_data[i]
        if(temp_number <= number):
            continue
        else:
            index = i
            break
    percent_data = percent_data[0:index] + [temp_number]
    cdf_data = cdf_data[0:index] + [temp_sum]
    def mul(x):
        return x*100
    cdf_data = map(mul,cdf_data)
    file.close
    return percent_data,cdf_data,index      

def plot_cdf(percent_data,cdf_data,index,picture_name,sample_name):
    line_color='#514d4d'
    fig,ax1 = plt.subplots(figsize=(8,8))
    ax2 = ax1.twinx()
    ax1.plot(percent_data,'-',label = 'Mapped bases distribution',linewidth = 2,color = '#0099cc')
    ax2.plot(cdf_data,'-',label = 'Cumulative distribution',linewidth = 2,color = '#FF6666')

    ax1.set_xlabel('Sequencing depth(x)', fontsize = 14)
    ax1.set_ylabel('Fraction of bases(%)', fontsize = 14)
    ax2.set_ylabel('Cumulative fraction of bases(%)', fontsize = 14)

    plt.suptitle(sample_name,y=0.95,fontsize=16)
    ax1.set_xlim([0-len(percent_data)*0.05,len(percent_data)*1.05]) # 设置坐标轴范围的语句有所变化

    #设置x轴
    x_label = []
    for label in ax1.get_xticks():
        x_label += [int(label)]
    x_label = x_label[1:len(x_label)-1]
    x_label[-1] = index-1
    ax1.set_xticks(x_label)
    x_label[-1] = str(x_label[-1])+'+'
    ax1.set_xticklabels(x_label)


    y1_label=[]
    for label in ax1.get_yticks():
        y1_label += [label*100]
    y1_label = y1_label[0:len(y1_label)]
#设置现在的标签
    ax1.set_yticklabels(y1_label)
    ax1.set_ylim(0,max(percent_data)*1.1)
    ax2.set_ylim(0,110)

    ax1.legend(loc=2,bbox_to_anchor=(0.55,0.99),fontsize="small",frameon=False)
    ax2.legend(loc=2,bbox_to_anchor=(0.55,0.96),fontsize="small",frameon=False)

########################################设置边框，刻度，label的颜色

    ax1.tick_params ( axis='both',color=line_color )
    #设置每条边框颜色
    for each in ax1.spines:
        ax1.spines[each].set_color(line_color)
    y1 = ax1.yaxis
    for label in y1.get_ticklabels():
        label.set_color(line_color)
    x1 = ax1.xaxis
    for label in x1.get_ticklabels():
        label.set_color(line_color)
    y2 = ax2.yaxis
    for label in y2.get_ticklabels():
        label.set_color(line_color)


    ax2.tick_params ( axis='both',color=line_color )
    #设置每条边框颜色
    for each in ax2.spines:
        ax2.spines[each].set_color(line_color)


    plt.savefig(picture_name + '.png')
    plt.savefig(picture_name + '.pdf')
    plt.cla()
    plt.clf()
    plt.close()



#openfile = "depth_frequency.txt"
#picture_name = "12.png"
#number = 0.01
#sample_name = "sample1"
#percent_data,cdf_data,index = get_data(openfile,number)
#plot_cdf(percent_data,cdf_data,index,picture_name,sample_name)
###################################################################
def main():
    parser= argparse.ArgumentParser( description='CDF')
    parser.add_argument('--input',help='open depth_frequency file name',dest='openfile')
    parser.add_argument('--number',help='ni shuo de  yu zhi',type=float,default=0.01,dest='number')
    parser.add_argument('--output',help='Name of output picture',dest='picture_name')
    parser.add_argument('--sample',help='Name of sample',dest='sample_name')

    args = parser.parse_args()
    openfile,picture_name,number,sample_name = args.openfile,args.picture_name,args.number,args.sample_name
    percent_data,cdf_data,index = get_data(openfile,number)
    plot_cdf(percent_data,cdf_data,index,picture_name,sample_name)

if __name__ == '__main__':
    main()


