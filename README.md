# Numerical-Methods-Exercises

A collection of numerical computing and machine learning exercises implemented in **MATLAB/Octave**, covering anomaly detection, kernel-based regression, matrix factorization, iterative linear-system solvers, and stochastic text modeling.

The repository is divided into three main parts. The first implements anomaly detection using a multivariate Gaussian model and automatic threshold selection. The second explores kernel regression together with several numerical methods for solving the resulting systems of equations. The third works with text corpora, word sequences, dictionaries, sparse matrices, and transition counts used to construct a stochastic language model.

The project combines mathematical formulas with practical numerical implementations. Instead of relying only on high-level built-in routines, several algorithms such as covariance estimation, Cholesky decomposition, Gauss-Jordan elimination, and the Conjugate Gradient method are implemented directly.

## Anomaly Detection

The anomaly-detection component models a dataset using a multivariate Gaussian distribution.

The first step is estimating the statistical parameters of the dataset.

`estimate_gaussian` computes the mean of every feature and constructs the covariance matrix by accumulating the outer product of the difference between each sample and the mean vector.

These values describe the center of the dataset and the way its features vary together.

Once the parameters are available, the probability density of each observation is calculated using the multivariate Gaussian distribution.

The implementation uses the covariance matrix determinant and inverse together with the standard quadratic form involving the difference between a sample and the estimated mean.

This produces one probability value for every observation in the dataset.

Samples with very low probability are considered potential anomalies because they are unlikely under the distribution estimated from the normal training data.

## Threshold Selection and Evaluation Metrics

Determining whether a probability is low enough to represent an anomaly requires choosing a threshold.

The project determines this threshold automatically using a labeled validation set.

The range between the minimum and maximum calculated probabilities is divided into 1001 candidate threshold values.

For every candidate epsilon, the implementation creates a prediction vector in which samples with probabilities below the threshold are marked as anomalies.

These predictions are compared with the expected labels in order to calculate the number of true positives, false positives, and false negatives.

From these values, the project calculates **precision**, **recall**, and the **F1 score**.

Precision measures how many detected anomalies are actually anomalies, while recall measures how many real anomalies were successfully detected.

The F1 score combines precision and recall into a single value and is used to select the threshold.

The candidate that produces the highest F1 score becomes the final epsilon used by the anomaly detector.

`identify_outliers` combines the complete process by estimating the Gaussian parameters, computing probabilities, selecting the threshold, and returning the indexes of observations whose probabilities fall below that threshold.

## Kernel Regression

The second major part of the repository implements kernel-based regression.

Instead of working only with the original feature representation, the model constructs a kernel matrix containing pairwise similarities between training examples.

The `build_kernel` function receives the input matrix together with a kernel function and evaluates that function for every pair of training samples.

This produces the complete kernel matrix used by the prediction system.

Three kernel functions are implemented.

The **linear kernel** computes the inner product between two feature vectors.

The **polynomial kernel** extends the inner product using a configurable degree.

The **Gaussian kernel** measures similarity according to the Euclidean distance between two vectors and a configurable sigma parameter.

Because the kernel is supplied as a function parameter, the same matrix-building and prediction logic can be reused with different similarity functions.

## Cholesky Decomposition and Matrix Operations

One method used to obtain the regression parameters is based on direct numerical linear algebra.

The project forms a matrix using the kernel matrix together with a regularization term based on the identity matrix.

A custom implementation of **Cholesky decomposition** is then used to factor a positive-definite matrix into a lower-triangular matrix and its transpose.

The lower-triangular matrix is constructed element by element.

For non-diagonal elements, previously calculated entries are used to remove contributions that have already been accounted for.

The diagonal entries are obtained from the remaining value through a square root.

The project also implements the inversion of a lower-triangular matrix.

`get_lower_inverse` creates an augmented matrix containing the original matrix together with an identity matrix and applies a Gauss-Jordan-style elimination procedure.

The diagonal elements are normalized, elements underneath the diagonal are eliminated, and partial pivoting is performed if a diagonal element is zero.

The resulting transformed matrix is then used in the direct calculation of the prediction parameters.

This part of the project connects kernel methods with classical numerical linear algebra rather than treating the parameter calculation as a single black-box matrix operation.

## Conjugate Gradient Method

The repository also provides an iterative alternative for calculating the prediction parameters.

The **Conjugate Gradient** method is implemented in `conjugate_gradient`.

The algorithm starts from an initial approximation and computes the corresponding residual.

During every iteration, a search direction is maintained and used to update the current solution.

A new residual is then calculated and used to construct the next conjugate search direction.

The process continues until either the residual norm becomes smaller than the configured tolerance or the maximum number of iterations is reached.

The iterative prediction path initializes the solution with a zero vector, uses a tolerance of `10^-6`, and allows up to 1000 iterations.

This provides two different approaches to the same general parameter-estimation problem: a direct method based on matrix factorization and inversion, and an iterative method based on Conjugate Gradient.

## Prediction and Dataset Splitting

Once the regression parameter vector has been calculated, predictions are evaluated using the selected kernel.

For a new input vector, `eval_value` evaluates the kernel between that vector and every training sample.

Each kernel value is multiplied by the corresponding learned coefficient and added to the final prediction.

The repository also contains a dataset-splitting utility.

`split_dataset` separates the feature matrix and target vector according to a supplied percentage.

The first portion of the observations becomes the training set, while the remaining samples form the prediction or test set.

This keeps the feature vectors and their associated target values synchronized during the split.

## Stochastic Text Modeling

The third part of the project works with text corpora and stochastic relationships between word sequences.

The input text is first tokenized into individual words and punctuation symbols.

The preprocessing logic separates punctuation appearing at the beginning or end of a token so that punctuation can be represented independently inside the corpus.

From this token sequence, the project extracts sequences containing `k` consecutive words.

Each sequence is joined into a single representation and stored inside a cell array.

The distinct vocabulary and the distinct set of k-word sequences are then obtained using unique-value operations.

Both collections are mapped to numerical indexes using `containers.Map`.

These mappings allow words and sequences to be efficiently connected with rows and columns of a numerical matrix.

## Sparse Stochastic Matrix

The main numerical representation of the text model is a sparse matrix.

Rows correspond to distinct sequences of `k` words, while columns correspond to distinct words in the vocabulary.

For every sequence found in the corpus, the implementation identifies the word that appears immediately after it.

The corresponding matrix entry is then incremented.

As a result, each row contains occurrence counts describing which words followed a particular sequence inside the original corpus.

The matrix is intentionally stored as a sparse matrix because most possible sequence-word combinations never appear in the text.

This representation avoids allocating a full dense matrix for large vocabularies and sequence sets.

The resulting counts can be interpreted as weights for possible next words.

The repository also contains a probability-based selection helper that normalizes a vector of weights, generates a random value, and selects an element according to the resulting cumulative probability distribution.

The infrastructure for sampling the next word and repeatedly generating additional words is present in the repository, while the corresponding `sample_next_word` and `sample_n_words` functions remain as scaffolding in the current implementation.

## Project Structure

The repository is organized into three main directories:

- `anomaly_detection/` — Gaussian parameter estimation, multivariate probability calculation, prediction checking, evaluation metrics, threshold optimization, and outlier identification
- `kernel_regression/` — kernel construction, linear, polynomial and Gaussian kernels, Cholesky decomposition, matrix inversion, Conjugate Gradient, prediction parameter calculation, prediction evaluation, and dataset splitting
- `stochastic_text_gen/` — tokenization, punctuation handling, k-word sequences, dictionaries, sparse transition matrices, probability-based selection, and text-generation scaffolding
- `README` — original implementation notes for the three parts of the project

The functions are separated according to their numerical role, making the repository useful as a collection of relatively small implementations that can be studied independently.

## Running the Code

The project consists of `.m` files written in MATLAB/Octave-style syntax and is especially suited for **GNU Octave**.

The individual functions can be called independently from the Octave environment depending on which part of the project is being tested.

The stochastic text section also contains `tema1_script.m`, which demonstrates the intended processing pipeline: loading a corpus, extracting the vocabulary, constructing k-word sequences, creating index dictionaries, and building the stochastic matrix.

The repository does not contain one single application entry point because the three directories represent separate numerical tasks.

## Technologies and Concepts

- MATLAB / GNU Octave
- Numerical computing
- Machine learning
- Anomaly detection
- Multivariate Gaussian distribution
- Mean and covariance estimation
- Probability density functions
- Precision
- Recall
- F1 score
- Threshold optimization
- Kernel regression
- Kernel matrices
- Linear kernel
- Polynomial kernel
- Gaussian kernel
- Cholesky decomposition
- Gauss-Jordan elimination
- Partial pivoting
- Lower-triangular matrices
- Matrix inversion
- Conjugate Gradient method
- Iterative numerical methods
- Direct numerical methods
- Regularization
- Dataset splitting
- Stochastic text modeling
- k-word sequences
- Sparse matrices
- `containers.Map`
- Vocabulary indexing
- Transition counts
- Weighted random sampling
