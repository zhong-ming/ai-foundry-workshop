from azure.identity import ClientSecretCredential, get_bearer_token_provider
from langchain_openai import AzureOpenAIEmbeddings
from dotenv import load_dotenv
import os
from langchain_openai.chat_models import AzureChatOpenAI
import tkinter as tk
from tkinter import scrolledtext


class AzureOpenAISetup:
    def __init__(self):
        load_dotenv()
        self.tenant_id = os.environ.get("tenant_id")
        self.client_id = os.environ.get("client_id")
        self.client_secret = os.environ.get("client_secret")
        self.model = os.environ.get("model_name")
        self.openai_version = os.environ.get("openai_version")

        self.refresh_token()
 
    def refresh_token(self):
        credential = ClientSecretCredential(
            self.tenant_id, self.client_id, self.client_secret)
        self.token = credential.get_token(
            "https://cognitiveservices.azure.com/.default")
        TenantId = os.getenv("AzureOpenAiTenantId")
        ClientId = os.getenv("AzureOpenAiClientId")
        ClientSecret = os.getenv("AzureOpenAiClientSecret")
        Endpoint =  os.getenv("AzureOpenAiEndpoint")
        Proxy = os.getenv("AzureOpenAiProxy")
        token_provider = get_bearer_token_provider(
            ClientSecretCredential(TenantId, ClientId, ClientSecret), "https://cognitiveservices.azure.com/.default"
            )
        self.embeddings = AzureOpenAIEmbeddings(
            model="text-embedding-ada-002",
            openai_api_key=self.token.token,
            azure_endpoint=os.environ.get("AzureOpenAiEndpoint","https://do-openai-instance.openai.azure.com/"),
            azure_ad_token_provider = token_provider,
        )

    def get_embeddings(self):
        return self.embeddings

    def get_token(self):
        return self.token
    
    def get_llm(self):
        TenantId = os.getenv("AzureOpenAiTenantId")
        ClientId = os.getenv("AzureOpenAiClientId")
        ClientSecret = os.getenv("AzureOpenAiClientSecret")
        Endpoint =  os.getenv("AzureOpenAiEndpoint")
        Proxy = os.getenv("AzureOpenAiProxy")
        token_provider = get_bearer_token_provider(
            ClientSecretCredential(TenantId, ClientId, ClientSecret), "https://cognitiveservices.azure.com/.default"
            )
        llm =  AzureChatOpenAI(
            azure_deployment=self.model,
            api_version=os.getenv('AzureOpenAiApiVersion'),
            azure_ad_token_provider = token_provider,
            azure_endpoint= Endpoint,
            openai_api_type="azure",
        )
        return llm

# Example usage
setup = AzureOpenAISetup()
llm = setup.get_llm()
# Create the UI
# Create the UI
def send_prompt():
    user_input = input_box.get()
    if user_input.lower() == 'exit':
        root.destroy()
    else:
        response = llm(user_input)
        response_box.insert(tk.END, "You: " + user_input + "\n")
        response_box.insert(tk.END, "Response: " + str(response) + "\n\n")
        input_box.delete(0, tk.END)

root = tk.Tk()
root.title("Azure OpenAI Chat")

frame = tk.Frame(root)
frame.pack(pady=10)

input_box = tk.Entry(frame, width=50)
input_box.pack(side=tk.LEFT, padx=10)

send_button = tk.Button(frame, text="Send", command=send_prompt)
send_button.pack(side=tk.LEFT)

response_box = scrolledtext.ScrolledText(root, width=60, height=20, wrap=tk.WORD)
response_box.pack(pady=10)

root.mainloop()


