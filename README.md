# NAGFS basic concept
NAG-FS(Network Atlas-Guided Feature Selection) for a fast and accurate graph data classification code, created by Islem Mhiri. Please contact islemmhiri1993@gmail.com for inquiries. Thanks. 

While typical feature selection (FS) methods aim to identify the most discriminative features in the original feature space for the target classification task, feature extraction (FE) methods cannot track the original features as they extract new discriminative features via projection. Hence, FS methods are more convenient for clinical applications for biomarker discovery. However, existing FS methods are generally challenged by space, time, scalability, and reproducibility. To address these issues, we design a simple but effective feature selection method, which identifies the most discriminative features by comparing healthy and disordered brain network atlases to learn.

![NAGFS pipeline](http://basira-lab.com/nagfs_0/)

# Detailed proposed NAGFS pipeline

This work has been published in the Journal of Medical Image Analysis 2020. **Network Atlas-Guided Feature Selection (NAG-FS)** is a network atlas-based connectomic feature selection method for a fast and accurate classification. Our learning-based framework comprises three key steps. (1) Estimation of a centered and representative network atlas, (2) Discriminative connectional biomarker identification, (3) Disease classification. Experimental results and comparisons with the state-of-the-art methods demonstrate that NAG-FS can achieve the best results in terms of classification accuracy and overall computational time. We evaluated our proposed framework  from ABIDE preprocessed dataset (http://preprocessed-connectomes-project.org/abide/). 

More details can be found at: https://www.sciencedirect.com/science/article/pii/S1361841519301367 or https://www.researchgate.net/publication/337092350_Joint_Functional_Brain_Network_Atlas_Estimation_and_Feature_Selection_for_Neurological_Disorder_Diagnosis_With_Application_to_Autism

![NAGFS pipeline](http://basira-lab.com/nagfs_1/)

![NAGFS pipeline](http://basira-lab.com/nagfs_2/)

In this repository, we release the NAGFS source code trained and tested in a simulated heterogeneous graph data from 2 Gaussian distributions as shown below:
![NAGFS pipeline](http://basira-lab.com/nagfs_4/) 

