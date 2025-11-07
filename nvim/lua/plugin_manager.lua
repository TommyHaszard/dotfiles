-- small plugin to allow for downloading plugins via version
--
local M = {}

function M.add(spec)
  local plugin_name = spec.src:match("([^/]+)$"):gsub("%.git$", "")
  local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start"
  local install_path = pack_path .. "/" .. plugin_name

  vim.fn.mkdir(pack_path, "p")

  if vim.fn.isdirectory(install_path) == 0 then
    print("Installing " .. plugin_name .. "...")
    vim.fn.system({
      "git", "clone", "--filter=blob:none",
      spec.src, install_path
    })
  end

  if spec.tag or spec.commit or spec.branch then
    local ref = spec.tag and ("tags/" .. spec.tag) or spec.commit or spec.branch
    vim.fn.system({ "git", "-C", install_path, "fetch", "--tags" })
    vim.fn.system({ "git", "-C", install_path, "checkout", ref })
  end

  vim.opt.rtp:prepend(install_path)
end

return M
