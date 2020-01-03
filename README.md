# NAGFS (Network Atlas-Guided Feature Selection)
NAG-FS(Network Atlas-Guided Feature Selection) for a fast and accurate graph data classification code, created by Islem Mhiri. Please contact islemmhiri1993@gmail.com for inquiries. Thanks. 

While typical feature selection (FS) methods aim to identify the most discriminative features in the original feature space for the target classification task, feature extraction (FE) methods cannot track the original features as they extract new discriminative features via projection. Hence, FS methods are more convenient for clinical applications for biomarker discovery. However, existing FS methods are generally challenged by space, time, scalability, and reproducibility. To address these issues, we design a simple but effective feature selection method, which identifies the most discriminative features by comparing healthy and disordered *brain network atlases to learn*.

![NAGFS pipeline](http://basira-lab.com/nagfs_0/)

# Detailed proposed NAGFS pipeline

This work has been published in the Journal of Medical Image Analysis 2020. **Network Atlas-Guided Feature Selection (NAG-FS)** is a network atlas-based connectomic feature selection method for a fast and accurate classification. Our learning-based framework comprises three key steps. (1) Estimation of a centered and representative network atlas, (2) Discriminative connectional biomarker identification, (3) Disease classification. Experimental results and comparisons with the state-of-the-art methods demonstrate that NAG-FS can achieve the best results in terms of classification accuracy and overall computational time. We evaluated our proposed framework  from ABIDE preprocessed dataset (http://preprocessed-connectomes-project.org/abide/). 

More details can be found at: https://www.sciencedirect.com/science/article/pii/S1361841519301367 or https://www.researchgate.net/publication/337092350_Joint_Functional_Brain_Network_Atlas_Estimation_and_Feature_Selection_for_Neurological_Disorder_Diagnosis_With_Application_to_Autism

![NAGFS pipeline](http://basira-lab.com/nagfs_1/)

![NAGFS pipeline](http://basira-lab.com/nagfs_2/)

# Demo

The code has been tested with MATLAB 2018a on Windows 10. GPU is not needed to run the code.

In this repository, we release the NAGFS source code trained and tested in a simulated heterogeneous graph data from 2 Gaussian distributions as shown below:

![NAGFS pipeline](http://basira-lab.com/nagfs_3/) 

**Data preparation**

We simulated random graph dataset from two Gaussian distributions using the function simulateData.m. The number of graphs in class 1, the number graphs in class 2, and the number of nodes (must be >20) are manually inputted by the user when starting the demo. 

To train and evaluate NAGFS code on other datasets, you need to provide:

• A tensor of size ((n-1) × m × m) stacking the symmetric matrices of the training subjects. n denotes the total number of subjects and m denotes the number of nodes.<br/>
• A vector of size (n-1) stacking the training labels.<br/>
• A number of selected features Nf.<br/>
• A boolean variables ‘displayResults’ ∈ [0, 1].<br/>
If displayResults = 1 ==> display (Atlas of group 1, Atlas of group 2, top features matrix and the circular graph).<br/>
If displayResults = 0 ==> no display.<br/>

The NAG-FS outputs are:

• A matrix of size (m × m) storing the network atlas of group 1. <br/>
• A matrix of size (m × m) storing the network atlas of group 2. <br/>
• A vector of size (Nf × 1) stacking the indices of the top discriminative features. <br/>

**Train and test NAG-FS**

To evaluate our framework, we used leave-one-out cross validation strategy.

To try our code, you can use: run_demo.m


# Example Results

If you set the number of samples (i.e., graphs) from class 1 to 30, from class 2 to 30, and the size of each graph to 60 (nodes), you will get the following outputs when running the demo:

![NAGFS pipeline](http://basira-lab.com/nagfs_4/) 

# Acknowledgement

We used the following codes from others as follows:

SIMLR code from https://github.com/BatzoglouLabSU/SIMLR/tree/SIMLR/MATLAB. 

SNF code from http://compbio.cs.toronto.edu/SNF/SNF/Software.html.

CircularGraph code from https://www.github.com/paul-kassebaummathworks/circularGraph.  

# Related references

Similarity Network Fusion (SNF): Wang, B., Mezlini, A.M., Demir, F., Fiume, M., Tu, Z., Brudno, M., HaibeKains, B., Goldenberg, A., 2014. Similarity network fusion for aggregating data types on a genomic scale. [http://www.cogsci.ucsd.edu/media/publications/nmeth.2810.pdf] (2014) [https://github.com/maxconway/SNFtool].

Single‐cell Interpretation via Multi‐kernel LeaRning (SIMLR): Wang, B., Ramazzotti, D., De Sano, L., Zhu, J., Pierson, E., Batzoglou, S.: SIMLR: a tool for large-scale single-cell analysis by multi-kernel learning. [https://www.biorxiv.org/content/10.1101/052225v3] (2017) [https://github.com/bowang87/SIMLR_PY].

Paul Kassebaum (2019). circularGraph (https://www.github.com/paul-kassebaum-mathworks/circularGraph), GitHub. Retrieved December 26, 2019

# Please cite the following paper when using NAG-FS:

@article{mhiri2019joint,
  title={Joint Functional Brain Network Atlas Estimation and Feature Selection for Neurological Disorder Diagnosis With Application to Autism},<br/>
  author={Mhiri, Islem and Rekik, Islem},<br/>
  journal={Medical Image Analysis},<br/>
  pages={101596},<br/>
  year={2019},<br/>
  publisher={Elsevier}<br/>
}<br/>

Paper link on ResearchGate:
https://www.researchgate.net/publication/337092350_Joint_Functional_Brain_Network_Atlas_Estimation_and_Feature_Selection_for_Neurological_Disorder_Diagnosis_With_Application_to_Autism

# Contributing
We always welcome contributions to help improve NAG-FS and evaluate our framework on other types of graph data. If you would like to contribute, please contact islemmhiri1993@gmail.com. Many thanks.







