# **Sentence Transformers & Multi-Task Learning - Task Analysis**

### **Task 1: Sentence Transformer Implementation**

#### **Design Decisions**
1. **Model Selection**: 
   - Chose **DistilBERT** (distilbert-base-uncased) as the backbone model. It is lightweight and provides a significant performance improvement while maintaining about 97% of BERT's accuracy, making it suitable for tasks with limited computational resources.

2. **Pooling Method**: 
   - **Mean pooling** was implemented to aggregate token embeddings. This method computes the mean of the last hidden states of tokens after applying attention masking, effectively summarizing the sentence in a single embedding vector. This is a simpler and effective method compared to other strategies like max pooling or using the `[CLS]` token.

3. **Normalization**: 
   - **L2 normalization** was applied to the output embeddings. Normalization ensures that embeddings have unit length, which is useful for similarity comparisons, particularly in tasks like clustering or retrieval, where cosine similarity becomes more effective.

4. **Testing Results**: 
   - After the implementation, the model successfully produced 768-dimensional sentence embeddings. These embeddings will be used for downstream tasks.

#### **Key Insights**
- DistilBERT was chosen for its efficient trade-off between performance and resource usage.
- The choice of mean pooling ensures that we capture an average representation of the sentence while avoiding any token-specific bias.
- Normalization of embeddings aids in improved similarity-based tasks.

### **Task 2: Multi-Task Learning Expansion**

#### **Design Decisions**
1. **Shared Backbone**:
   - The transformer backbone is shared between the tasks. This approach allows the model to leverage shared representations, enabling knowledge transfer across tasks. 

2. **Task-Specific Heads**:
   - Added **two task-specific heads**:
     - **Sentence Classification Head**: For Task A (3 classes: Technology, Science, Other).
     - **Sentiment Analysis Head**: For Task B (3 classes: Positive, Negative, Neutral).
   - These heads are small feedforward networks that adapt the shared features from the transformer for specific tasks.

3. **Regularization**:
   - Dropout (0.1) was added in both heads to reduce the risk of overfitting.

4. **Task Independence**:
   - Each task has its own set of logits, allowing for independent learning for each classification task, while sharing the common sentence embeddings.

#### **Key Insights**
- **Shared backbone** was chosen to improve efficiency and allow task-specific heads to focus on specialized outputs while benefiting from common learned features.
- Task-specific heads give the model the flexibility to adapt to different tasks without interfering with one another.
- **Dropout** was included to ensure that the model generalizes well to unseen data.

### **Task 3: Training Strategy Analysis**

#### **A) Implications & Advantages of Different Training Scenarios**
1. **Frozen Entire Network Approach**:
   - **Definition**: All parameters are frozen, and only the classification heads are trained.
   - **Advantages**: 
     - Extremely fast training due to no backpropagation through the transformer backbone.
     - Stability of pre-trained knowledge is maintained.
     - **Best use case**: When working with minimal labeled data, making the most of pre-trained features without overfitting.

2. **Frozen Backbone with Trainable Heads**:
   - **Definition**: Transformer layers are frozen, but the task-specific heads are trained.
   - **Advantages**: 
     - A balanced approach combining efficient training and task-specific adaptation.
     - 90%+ fewer trainable parameters than full fine-tuning.
     - **Best use case**: Default approach for medium-sized datasets (100–10,000 examples).

3. **Partially Frozen Architecture**:
   - **Definition**: One task head is frozen while the rest of the model is fine-tuned.
   - **Advantages**: 
     - Targets adaptation where it’s most needed.
     - Reduces resource usage when tasks have unequal data requirements.
     - **Best use case**: When tasks have varying amounts of labeled data.

#### **B) Transfer Learning Approach in NLP**
1. **Choosing Pre-trained Model**: 
   - BERT-base was selected for its ability to capture a wide range of linguistic patterns. The model has been trained on a massive English corpus, making it suitable for general NLP tasks.

2. **Freezing and Unfreezing Layers**:
   - Lower layers of BERT (capturing basic linguistic features) will be frozen to prevent overfitting, while upper layers and task-specific heads will be fine-tuned for the tasks at hand.

3. **Strategy for Fine-Tuning**:
   - **Freeze lower layers** to keep general linguistic knowledge intact.
   - **Fine-tune the upper layers** and task heads to adapt the model to specific downstream tasks.

#### **Key Insights**
- **Frozen backbone** helps to preserve the general knowledge from BERT while still allowing task-specific customization.
- **Partially frozen architecture** offers a flexible approach when dealing with tasks of unequal difficulty or data availability.
- **Transfer learning** is vital when working with limited data, as it allows the model to reuse pre-trained features and adapt them to specific tasks.

### **Task 4: Training Loop Implementation (BONUS)**

#### **Design Decisions**
1. **Dataset**:
   - A simple dataset consisting of sentences along with their respective classification and sentiment labels was used for training. The dataset was created with diverse examples, including technology, science, and neutral/positive/negative sentiments.

2. **Model Training**:
   - The training loop includes:
     - **Cross-entropy loss** for both classification and sentiment analysis tasks.
     - **Optimizer**: Adam was used due to its adaptive learning rate and robustness in training deep models.
     - **Training Loop**: The loop iterates over multiple epochs, updating the model parameters through backpropagation.

3. **Metrics**:
   - Accuracy was tracked for both tasks (classification and sentiment) to ensure the model's performance was improving over time.

#### **Key Insights**
- The training loop effectively balances between optimizing both classification and sentiment tasks using shared model weights.
- Using a batch size of 2 and Adam optimizer ensures stable training and faster convergence, especially on smaller datasets.
