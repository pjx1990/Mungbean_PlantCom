# _*_ coding: utf-8 _*_

'''
Data frame rows and columns are transposed
'''
import configparser
import argparse
import pandas as pd
import sys 
import os


def ArgParse():
    parser = argparse.ArgumentParser()
    help = "import genotype file need to be trasnposed"
    parser.add_argument('--geno', required=True, help=help)
    help = "output directory. [current path default]"
    parser.add_argument('--outdir',default=os.getcwd(),help=help)
    args = parser.parse_args()
    return args

def transpose(df):
    data = df.values
    data = list(map(list,zip(*data)))
    data = pd.DataFrame(data)
    return data

def uncompressed(filename):
    if filename.endswith(".gz"):
        newfile = filename.rsplit(".",1)[0]
        os.system("gunzip -c "+filename+" > "+newfile)
        outfile = "t_"+".".join(filename.split(".")[0:-1]).split("/")[-1]
    elif filename.endswith(".zip"):
        os.system("unzip -o "+filename+" -d "+filename.rsplit("/",1)[0])
        newfile = filename.rsplit(".",1)[0]
        outfile = "t_"+".".join(filename.split(".")[0:-1]).split("/")[-1]
    else:
        newfile = filename
        outfile = "t_"+filename.split("/")[-1]
    return newfile,outfile

def main():                                                                                           
    args = ArgParse()
    infile = args.geno
    outdir = os.path.abspath(args.outdir)
    if not os.path.exists(outdir):
        os.makedirs(outdir)
    newfile,outfilename = uncompressed(infile)
    outfile = outdir+'/'+outfilename
    if newfile.endswith(".csv"):
        df = pd.read_csv(newfile,header= None)
        transpose(df).to_csv(outfile,header=None,index=0)
    elif newfile.endswith(".txt") or newfile.endswith(".tsv"):
        df = pd.read_csv(newfile,sep='\t',header= None)
        transpose(df).to_csv(outfile,sep='\t',header=None,index=0)
    elif newfile.endswith(".xls"):
        df = pd.read_excel(newfile,header=None)
        transpose(df).to_excel(outfile,header=None,index=None)
    elif newfile.endswith(".xlsx"):
        df = pd.read_excel(newfile,engine='openpyxl',header=None)
        transpose(df).to_excel(outfile,header=None,index=None)
    else:
        print("Invalid file format! Please input a csv/txt/xls/xlsx and its corresponding gz/zip file!")
        sys.exit()

if __name__ == '__main__':
    main()
