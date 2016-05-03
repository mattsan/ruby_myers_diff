require "myers_diff/version"

module MyersDiff
  VItem = Struct.new(:y, :node)
  TreeNode = Struct.new(:edit_type, :prev)

  def self.diff(sequence1, sequence2)
    size1 = sequence1.size
    size2 = sequence2.size

    v = (size1 + size2 + 1).times.map { VItem.new(0, nil) }

    (size1 + size2 + 1).times do |d|
      (-d..d).step(2) do |k|
        next if (k < -size1) || (size2 < k)

        v_k   = v[k + size1]
        v_kp1 = v[k + size1 + 1]
        v_km1 = v[k + size1 - 1]

        if d != 0
          if (k == -d) || (k == -size1) || ((k != d) && (k != size2) && ((v_km1.y + 1) < v_kp1.y))
            v_k.y = v_kp1.y
            v_k.node = TreeNode.new(:DELETE, v_kp1.node)
          else
            v_k.y = v_km1.y + 1
            v_k.node = TreeNode.new(:ADD, v_km1.node)
          end
        end

        while ((v_k.y - k) < size1) && (v_k.y < size2) && (sequence1[v_k.y - k] == sequence2[v_k.y])
          v_k.node = TreeNode.new(:COMMON, v_k.node)
          v_k.y += 1
        end

        if ((v_k.y - k) >= size1) && (v_k.y >= size2)
          ses = []
          node = v_k.node
          while node
            ses.push node.edit_type
            node = node.prev
          end
          return ses.reverse
        end
      end
    end

    raise "not found"
  end
end
