# Antigravity Folder Guide

## Overview
A small toolkit of coding rules and workflow helpers used by Antigravity.

## What's New in v2.0 🚀
- **New Skills Added:**
  - `systematic-debugging`: Giao thức gỡ lỗi 4 bước nghiêm ngặt (Reproduce, Trace, Hypothesis, Validate) đảm bảo tìm đúng nguyên nhân gốc rễ trước khi sửa.
  - `problem-solving`: Bộ công cụ tư duy (Inversion, Scale, Simplification) giúp xử lý các bài toán kỹ thuật phức tạp và tối ưu kiến trúc.
- **Rule & Workflow Upgrades:**
  - **Team-based Workflows:** Hệ thống quy trình phối hợp giữa Architect (Planning), Developer (Coding) và Repo Reader giúp quản lý task chuyên nghiệp.
  - **Stricter Rules:** Cập nhật Python Standards (type hints, docstrings) và Giao thức Logging bắt buộc (`.agent-execution/`) để theo dõi mọi dấu vết thay đổi.


## Copy the prompt set into `~/.gemini`
```bash
# ensure target exists
mkdir -p ~/.gemini

# copy skills and workflows into your home config (skipping GEMINI.md)
cp -r ./gemini/antigravity ~/.gemini/
cp -r ./gemini/skills ~/.gemini/
```


