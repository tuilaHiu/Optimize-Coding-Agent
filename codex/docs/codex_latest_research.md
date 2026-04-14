  # Nghiên Cứu Codex Mới Nhất

Ngày tổng hợp: 2026-04-10

## Mục tiêu

Tài liệu này tổng hợp các thông tin chính thức mới nhất về Codex từ OpenAI, với trọng tâm là những gì hữu ích cho việc thiết kế một bộ coding agent theo mô hình `1 main orchestrator + nhiều subagents`.

## Tóm tắt điều quan trọng nhất

- Codex hiện không còn nên được hiểu là chỉ một model hay một CLI tool. Theo docs và các bài công bố mới, Codex là một hệ agent coding đa bề mặt gồm app, CLI, IDE extension, web/cloud, integrations, skills, automations, worktrees và cơ chế approvals/sandboxing.
- OpenAI hiện mô tả Codex là coding agent có thể đọc, sửa, chạy code, làm review, chạy background tasks, hoạt động song song, và phối hợp nhiều agent.
- Về model guidance hiện tại trong Codex, OpenAI khuyến nghị `gpt-5.4` cho đa số tác vụ, `gpt-5.4-mini` cho tác vụ nhẹ hơn hoặc subagents, và `gpt-5.3-codex-spark` cho vòng lặp coding cực nhanh theo kiểu research preview.
- Về orchestration, docs của Codex hiện đã có khái niệm subagents chính thức: Codex có thể spawn specialized agents song song rồi gom kết quả. Đây là pattern rất gần với bài toán bạn đang thiết kế.
- Về safety, OpenAI đang đẩy mạnh mô hình "sandbox + approvals + rules + worktrees + review thủ công" thay vì cho agent toàn quyền mặc định.

## Codex hiện là gì

- Trang Codex chính thức mô tả Codex là "a coding agent that helps you build and ship with AI", đồng thời nhấn mạnh đây là "the best way to build with agents".  
  Nguồn: https://openai.com/codex/
- Docs Codex cloud mô tả: Codex có thể đọc, sửa và chạy code; hỗ trợ build nhanh hơn, fix bug và hiểu codebase lạ; với Codex cloud, agent có thể làm việc nền và song song trong môi trường cloud riêng.  
  Nguồn: https://developers.openai.com/codex/cloud
- Bài giới thiệu Codex app ngày 2026-02-02 nói rõ Codex app là "command center for agents", được thiết kế để quản lý nhiều agents cùng lúc, chạy song song và cộng tác với các tác vụ dài hơi.  
  Nguồn: https://openai.com/index/introducing-the-codex-app/
- Bài giới thiệu GPT-5.3-Codex ngày 2026-02-05 cho thấy Codex đang được định vị rộng hơn coding thuần túy: từ viết code sang "operate a computer and complete work end to end", mở rộng sang knowledge work có tính thực thi.  
  Nguồn: https://openai.com/index/introducing-gpt-5-3-codex/


## Các capability nổi bật cần chú ý

- Trang Codex cloud nói rõ Codex có thể đọc, edit và run code, xử lý task nền, và chạy song song trong cloud environment riêng.  
  Nguồn: https://developers.openai.com/codex/cloud
- Trang Codex landing page nhấn mạnh Codex xử lý end-to-end các việc như feature work, complex refactors và migrations.  
  Nguồn: https://openai.com/codex/
- Trang Codex app nhấn mạnh ba khối rất quan trọng:
  - multi-agent workflows,
  - skills để mở rộng workflow theo chuẩn team,
  - automations cho recurring background work.
  Nguồn: https://openai.com/codex/
- Bài GA nói Codex SDK cho phép embed cùng agent đang chạy trong Codex CLI vào workflow và app riêng, có structured outputs và session resume.  
  Nguồn: https://openai.com/index/codex-now-generally-available/

## Subagents: thông tin đặc biệt quan trọng cho bài toán của bạn

- Docs Subagents của Codex nói rõ: Codex có thể chạy subagent workflows bằng cách spawn các agent chuyên biệt song song rồi gom kết quả vào một response. Pattern được nêu phù hợp với các task song song cao như codebase exploration hoặc triển khai feature plan nhiều bước.  
  Nguồn: https://developers.openai.com/codex/subagents
- Docs cũng nói Codex cho phép định nghĩa custom agents với model config và instructions khác nhau theo task.  
  Nguồn: https://developers.openai.com/codex/subagents
- Current releases bật subagent workflows theo mặc định, nhưng Codex chỉ spawn subagents khi người dùng explicit yêu cầu. Đây là tín hiệu quan trọng về mặt UX và kiểm soát chi phí.  
  Nguồn: https://developers.openai.com/codex/subagents
- Subagent activity hiện được surfaced trong Codex app và CLI; IDE extension "coming soon".  
  Nguồn: https://developers.openai.com/codex/subagents
- Docs nói Codex xử lý orchestration giữa agents: spawn, route follow-up, wait for results và close agent threads.  
  Nguồn: https://developers.openai.com/codex/subagents
- Docs Subagents cũng nêu sẵn ba built-in agent types:
  - `default`: general-purpose fallback,
  - `worker`: execution-focused cho implementation và fixes,
  - `explorer`: read-heavy cho codebase exploration.
  Nguồn: https://developers.openai.com/codex/subagents
- Custom agents được định nghĩa bằng các file TOML riêng trong `~/.codex/agents/` cho personal scope hoặc `.codex/agents/` cho project scope.  
  Nguồn: https://developers.openai.com/codex/subagents

## Models và model guidance hiện tại

- Theo trang Models của Codex docs, model được khuyến nghị cho hầu hết tác vụ là `gpt-5.4`. Mô tả chính thức: model frontier cho professional work, kết hợp coding capabilities của GPT-5.3-Codex với reasoning, tool use và agentic workflows mạnh hơn.  
  Nguồn: https://developers.openai.com/codex/models
- `gpt-5.4-mini` được mô tả là model mini nhanh và hiệu quả cho responsive coding tasks và subagents.  
  Nguồn: https://developers.openai.com/codex/models
- `gpt-5.3-codex` vẫn được mô tả là industry-leading coding model cho software engineering phức tạp, và coding capabilities của nó hiện cũng power GPT-5.4.  
  Nguồn: https://developers.openai.com/codex/models
- `gpt-5.3-codex-spark` là research preview cho coding iteration gần real-time, available cho ChatGPT Pro users.  
  Nguồn: https://developers.openai.com/codex/models
- Chính docs Codex hiện khuyên:
  - bắt đầu với `gpt-5.4` cho đa số task,
  - dùng `gpt-5.4-mini` cho task nhẹ hơn hoặc subagents.
  Nguồn: https://developers.openai.com/codex/models
- Nếu không cấu hình model riêng, Codex app, CLI và IDE extension sẽ default sang một recommended model; trong docs hiện tại ví dụ cấu hình mặc định là `gpt-5.4`.  
  Nguồn: https://developers.openai.com/codex/models
- Docs Models cũng nói hỗ trợ `Chat Completions API` trong Codex đang bị deprecated và sẽ bị loại bỏ ở các bản sau; nếu cần tích hợp tương thích tương lai, nên ưu tiên hướng `Responses API`.  
  Nguồn: https://developers.openai.com/codex/models

## Skills, AGENTS.md, worktrees, automations

- Skills hiện là first-class concept trong Codex:
  - dùng để đóng gói instructions, resources, scripts,
  - hỗ trợ reusable workflows,
  - có progressive disclosure để tiết kiệm context: Codex chỉ load full `SKILL.md` khi quyết định dùng skill.
  Nguồn: https://developers.openai.com/codex/skills
- Docs AGENTS.md nói Codex đọc `AGENTS.md` trước khi làm việc, build instruction chain theo thứ tự global scope rồi project scope, và file gần thư mục hiện tại hơn sẽ override mạnh hơn.  
  Nguồn: https://developers.openai.com/codex/guides/agents-md
- Worktrees là cơ chế quan trọng để cho Codex làm nhiều task độc lập song song trong cùng project mà không đụng vào nhau. Mỗi worktree là một checkout riêng, cho phép làm việc trên nhiều branch song song.  
  Nguồn: https://developers.openai.com/codex/app/worktrees
- Automations là recurring tasks chạy nền trong Codex app. Automations có thể chạy ở local project hoặc worktree mới, và có thể phối hợp với skills.  
  Nguồn: https://developers.openai.com/codex/app/automations

## Sandboxing, approvals, rules, internet access

- Docs sandboxing mô tả ba sandbox mode phổ biến:
  - `read-only`
  - `workspace-write`
  - `danger-full-access`
  Nguồn: https://developers.openai.com/codex/concepts/sandboxing
- Approval policy phổ biến gồm:
  - `untrusted`
  - `on-request`
  - `never`
  Nguồn: https://developers.openai.com/codex/concepts/sandboxing
- Docs nhấn mạnh `workspace-write` là default low-friction mode cho local work; còn `danger-full-access` chỉ nên dùng khi thực sự muốn full access.  
  Nguồn: https://developers.openai.com/codex/concepts/sandboxing
- Khi cần ngoại lệ hẹp, docs khuyên dùng `rules` để allow/prompt/forbid command prefixes thay vì mở rộng sandbox quá rộng.  
  Nguồn: https://developers.openai.com/codex/concepts/sandboxing
- Trang "Agent approvals & security" nói rõ mặc định agent chạy với network access tắt; local Codex dùng OS-enforced sandbox cộng với approval policy.  
  Nguồn: https://developers.openai.com/codex/agent-approvals-security
- Với Codex cloud, internet access mặc định bị block trong agent phase; setup scripts vẫn có internet để cài dependencies. Nếu cần, có thể bật per environment và hạn chế bằng domain allowlist cùng HTTP methods.  
  Nguồn: https://developers.openai.com/codex/cloud/internet-access
- Bài giới thiệu Codex app cũng nói rõ mặc định agent chỉ được sửa file trong folder/branch đang làm, dùng cached web search, và phải xin quyền cho các lệnh cần elevated permissions như network access.  
  Nguồn: https://openai.com/index/introducing-the-codex-app/

## Workflow patterns OpenAI đang khuyến khích

- Workflows doc của Codex thể hiện mô hình rất rõ:
  - lập kế hoạch local trước,
  - sau đó delegate implementation dài hơi lên cloud,
  - review diff,
  - tạo PR hoặc kéo patch về local để test và hoàn thiện.
  Nguồn: https://developers.openai.com/codex/workflows
- Workflows doc cũng khuyên iterate bằng các prompt nhỏ và cụ thể thay vì yêu cầu quá rộng ngay từ đầu.  
  Nguồn: https://developers.openai.com/codex/workflows
- Khi user revert hoặc chỉnh tay một thay đổi, docs khuyên phải nói lại cho Codex biết để nó không overwrite thay đổi đó ở lượt sau. Điều này nhấn mạnh tầm quan trọng của state synchronization giữa orchestrator và workers.  
  Nguồn: https://developers.openai.com/codex/workflows

## Những kết luận thực dụng cho kiến trúc `main orchestrator + subagents`

- `Main agent` nên đóng vai trò orchestration rõ ràng:
  - phân loại task,
  - quyết định task nào làm local, task nào delegate,
  - tổng hợp output,
  - giữ instruction chain và trạng thái làm nguồn chân lý.

- `Subagents` nên là worker chuyên biệt:
  - codebase explorer,
  - implementation worker,
  - reviewer,
  - verifier,
  - context updater.
  Đây là pattern rất gần với cách OpenAI mô tả subagent workflows.

- Nên ưu tiên model split theo đúng guidance hiện tại:
  - `gpt-5.4` cho main orchestrator hoặc các task khó, nhiều ràng buộc, cần reasoning và điều phối.
  - `gpt-5.4-mini` cho subagents nhẹ hơn, exploratory tasks, fan-out song song hoặc background helpers.

- Spawn subagents chỉ khi có lợi ích rõ rệt về parallelism hoặc specialization.
  Lý do: docs nói subagents tiêu tốn token nhiều hơn comparable single-agent runs.

- Nên cô lập write scope của từng worker.
  Worktrees của Codex là tín hiệu rất mạnh rằng multi-agent coding nên đi cùng môi trường làm việc tách biệt để giảm xung đột.

- Nên coi `AGENTS.md` và `skills` là hai lớp điều khiển khác nhau:
  - `AGENTS.md` cho policy, conventions, expectations theo scope thư mục.
  - `skills` cho reusable workflow bundles, resources và scripts.

- Nên thiết kế rõ boundary cho approvals và sandbox:
  - task đọc/scan chỉ cần `read-only`,
  - task sửa code local nên ở `workspace-write`,
  - chỉ cho full access hoặc network khi task yêu cầu thật sự.

- Nên có cơ chế đồng bộ trạng thái sau mỗi worker:
  - file nào đã đổi,
  - test nào đã chạy,
  - assumption nào đang còn mở,
  - có cần rebase/review/retry hay không.

## Timeline các mốc quan trọng

- 2025-05-16: OpenAI giới thiệu Codex research preview như cloud-based software engineering agent.  
  Nguồn: https://openai.com/index/introducing-codex/
- 2025-09-15: OpenAI giới thiệu các nâng cấp cho Codex và GPT-5-Codex.  
  Nguồn: https://openai.com/index/introducing-upgrades-to-codex/
- 2025-10-06: Codex general availability, thêm Slack integration, Codex SDK, admin tools.  
  Nguồn: https://openai.com/index/codex-now-generally-available/
- 2025-12-18: OpenAI giới thiệu GPT-5.2-Codex.  
  Nguồn: https://openai.com/index/introducing-gpt-5-2-codex/
- 2026-02-02: OpenAI giới thiệu Codex app cho macOS.  
  Nguồn: https://openai.com/index/introducing-the-codex-app/
- 2026-02-05: OpenAI giới thiệu GPT-5.3-Codex.  
  Nguồn: https://openai.com/index/introducing-gpt-5-3-codex/
- 2026-03-04: Codex app có trên Windows.  
  Nguồn: https://openai.com/index/introducing-the-codex-app/
- 2026-04-02: OpenAI công bố pay-as-you-go pricing cho teams và Codex-only seats cho Business/Enterprise. Đây là một trong những cập nhật mới nhất về mặt thương mại hóa Codex.  
  Nguồn: https://openai.com/index/codex-flexible-pricing-for-teams/

## Suy luận của tôi từ các nguồn

- Tôi suy luận rằng Codex hiện là một "shared agent layer" đa surface hơn là một sản phẩm đơn lẻ. Tức là cùng một identity, cùng session/config/instruction model, nhưng được bọc bởi app, CLI, IDE, cloud và integrations khác nhau.
- Tôi cũng suy luận rằng hướng thiết kế của OpenAI đang đi theo mô hình "orchestrated teams of agents" chứ không chỉ một coding assistant đơn tuyến. Điều này xuất hiện nhất quán ở app, subagents, worktrees, automations và workflow docs.
- Tôi không thấy một trang duy nhất mô tả trọn vẹn toàn bộ sơ đồ kiến trúc runtime nội bộ của Codex. Vì vậy, các kết luận về "kiến trúc sản phẩm tổng thể" vẫn là inference, không phải câu chữ chính thức từ một tài liệu duy nhất.

## Nguồn chính

- https://openai.com/codex/
- https://openai.com/index/introducing-codex/
- https://openai.com/index/introducing-upgrades-to-codex/
- https://openai.com/index/codex-now-generally-available/
- https://openai.com/index/introducing-the-codex-app/
- https://openai.com/index/introducing-gpt-5-3-codex/
- https://openai.com/index/codex-flexible-pricing-for-teams/
- https://developers.openai.com/codex/cloud
- https://developers.openai.com/codex/models
- https://developers.openai.com/codex/subagents
- https://developers.openai.com/codex/skills
- https://developers.openai.com/codex/guides/agents-md
- https://developers.openai.com/codex/concepts/sandboxing
- https://developers.openai.com/codex/agent-approvals-security
- https://developers.openai.com/codex/cloud/internet-access
- https://developers.openai.com/codex/app/worktrees
- https://developers.openai.com/codex/app/automations
- https://developers.openai.com/codex/workflows
