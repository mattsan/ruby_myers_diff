require 'spec_helper'

describe MyersDiff do
  it 'has a version number' do
    expect(MyersDiff::VERSION).not_to be nil
  end

  context '同じ長さの文字列の場合' do
    context '同じ値の文字列の場合' do
      it { expect(MyersDiff.diff('A', 'A')).to eq([:COMMON]) }
      it { expect(MyersDiff.diff('AB', 'AB')).to eq([:COMMON, :COMMON]) }
      it { expect(MyersDiff.diff('ABC', 'ABC')).to eq([:COMMON, :COMMON, :COMMON]) }
    end

    context '一文字が異なる場合' do
      it { expect(MyersDiff.diff('A', '1')).to eq([:DELETE, :ADD]) }
      it { expect(MyersDiff.diff('AB', '1B')).to eq([:DELETE, :ADD, :COMMON]) }
      it { expect(MyersDiff.diff('AB', 'A2')).to eq([:COMMON, :DELETE, :ADD]) }
      it { expect(MyersDiff.diff('ABC', '1BC')).to eq([:DELETE, :ADD, :COMMON, :COMMON]) }
      it { expect(MyersDiff.diff('ABC', 'A2C')).to eq([:COMMON, :DELETE, :ADD, :COMMON]) }
      it { expect(MyersDiff.diff('ABC', 'AB3')).to eq([:COMMON, :COMMON, :DELETE, :ADD]) }
    end

    context '一文字左にずれている場合' do
      it { expect(MyersDiff.diff('AB', '_A')).to eq([:ADD, :COMMON, :DELETE]) }
      it { expect(MyersDiff.diff('ABC', '_AB')).to eq([:ADD, :COMMON, :COMMON, :DELETE]) }
    end

    context '一文字右にずれている場合' do
      it { expect(MyersDiff.diff('AB', 'B_')).to eq([:DELETE, :COMMON, :ADD]) }
      it { expect(MyersDiff.diff('ABC', 'BC_')).to eq([:DELETE, :COMMON, :COMMON, :ADD]) }
    end

    context '異なる文字列の場合' do
      it { expect(MyersDiff.diff('AB', 'YZ')).to eq([:DELETE, :DELETE, :ADD, :ADD]) }
      it { expect(MyersDiff.diff('ABC', 'XYZ')).to eq([:DELETE, :DELETE, :DELETE, :ADD, :ADD, :ADD]) }
    end
  end

  context '第一引数の文字列が長い場合' do
    context '先頭に文字がある場合' do
      it { expect(MyersDiff.diff('_A', 'A')).to eq([:DELETE, :COMMON]) }
      it { expect(MyersDiff.diff('_AB', 'AB')).to eq([:DELETE, :COMMON, :COMMON]) }
      it { expect(MyersDiff.diff('_ABC', 'ABC')).to eq([:DELETE, :COMMON, :COMMON, :COMMON]) }
    end

    context '末尾に文字がある場合' do
      it { expect(MyersDiff.diff('A_', 'A')).to eq([:COMMON, :DELETE]) }
      it { expect(MyersDiff.diff('AB_', 'AB')).to eq([:COMMON, :COMMON, :DELETE]) }
      it { expect(MyersDiff.diff('ABC_', 'ABC')).to eq([:COMMON, :COMMON, :COMMON, :DELETE]) }
    end

    context '途中にに文字がある場合' do
      it { expect(MyersDiff.diff('A_B', 'AB')).to eq([:COMMON, :DELETE, :COMMON]) }
      it { expect(MyersDiff.diff('A_BC', 'ABC')).to eq([:COMMON, :DELETE, :COMMON, :COMMON]) }
      it { expect(MyersDiff.diff('AB_C', 'ABC')).to eq([:COMMON, :COMMON, :DELETE, :COMMON]) }
    end
  end

  context '第二引数の文字列が長い場合' do
    context '先頭に文字がある場合' do
      it { expect(MyersDiff.diff('A', '_A')).to eq([:ADD, :COMMON]) }
      it { expect(MyersDiff.diff('AB', '_AB')).to eq([:ADD, :COMMON, :COMMON]) }
      it { expect(MyersDiff.diff('ABC', '_ABC')).to eq([:ADD, :COMMON, :COMMON, :COMMON]) }
    end

    context '末尾に文字がある場合' do
      it { expect(MyersDiff.diff('A', 'A_')).to eq([:COMMON, :ADD]) }
      it { expect(MyersDiff.diff('AB', 'AB_')).to eq([:COMMON, :COMMON, :ADD]) }
      it { expect(MyersDiff.diff('ABC', 'ABC_')).to eq([:COMMON, :COMMON, :COMMON, :ADD]) }
    end

    context '途中にに文字がある場合' do
      it { expect(MyersDiff.diff('AB', 'A_B')).to eq([:COMMON, :ADD, :COMMON]) }
      it { expect(MyersDiff.diff('ABC', 'A_BC')).to eq([:COMMON, :ADD, :COMMON, :COMMON]) }
      it { expect(MyersDiff.diff('ABC', 'AB_C')).to eq([:COMMON, :COMMON, :ADD, :COMMON]) }
    end
  end

  context '空文字列の場合' do
    it { expect(MyersDiff.diff('A', '')).to eq([:DELETE]) }
    it { expect(MyersDiff.diff('AB', '')).to eq([:DELETE, :DELETE]) }
    it { expect(MyersDiff.diff('ABC', '')).to eq([:DELETE, :DELETE, :DELETE]) }
    it { expect(MyersDiff.diff('', 'A')).to eq([:ADD]) }
    it { expect(MyersDiff.diff('', 'AB')).to eq([:ADD, :ADD]) }
    it { expect(MyersDiff.diff('', 'ABC')).to eq([:ADD, :ADD, :ADD]) }
    it { expect(MyersDiff.diff('', '')).to eq([]) }
  end
end
