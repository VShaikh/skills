import torch
print(f"PyTorch Version: {torch.__version__}") 
# IT MUST SAY: 2.x.x+cu124 (or cu121)

print(f"CUDA Available: {torch.cuda.is_available()}")
# THIS SHOULD NOW BE: True

if torch.cuda.is_available():
    print(f"GPU Name: {torch.cuda.get_device_name(0)}")

