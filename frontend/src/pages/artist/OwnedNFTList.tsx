import React from "react";
import styled from "styled-components";
import { ThumbnailGrid } from "../../stories/thumbnail/ThumbnailGrid";
import { useMediaQuery } from "react-responsive";

const dummyItemList = [
  {
    authorName: '',
    itemTitle: '',
    owner_address: '',
    itemImageUrl: ''
  },
  {
    authorName: '',
    itemTitle: '',
    owner_address: '',
    itemImageUrl: ''
  },
  {
    authorName: '',
    itemTitle: '',
    owner_address: '',
    itemImageUrl: ''
  },
  {
    authorName: '',
    itemTitle: '',
    owner_address: '',
    itemImageUrl: ''
  },
  {
    authorName: '',
    itemTitle: '',
    owner_address: '',
    itemImageUrl: ''
  },
  {
    authorName: '',
    itemTitle: '',
    owner_address: '',
    itemImageUrl: ''
  },
  {
    authorName: '',
    itemTitle: '',
    owner_address: '',
    itemImageUrl: ''
  },
  {
    authorName: '',
    itemTitle: '',
    owner_address: '',
    itemImageUrl: ''
  },
  {
    authorName: '',
    itemTitle: '',
    owner_address: '',
    itemImageUrl: ''
  },
  {
    authorName: '',
    itemTitle: '',
    owner_address: '',
    itemImageUrl: ''
  },
]

const Container = styled.div`
  display: flex;
  margin: auto;
  padding: 5rem 2rem;
  justify-content: center;
`;

const OwnedNFTList = () => {
  const isPc = useMediaQuery({ minWidth: 768 });
  const isTablet = useMediaQuery({ minWidth: 500 });
  const columnCount = isPc ? 4 : isTablet ? 3 : 3;
  const gridSize = isPc ? '52rem' : isTablet ? '40rem' : '20rem';
  return (
    <Container>
      <ThumbnailGrid
        itemList={dummyItemList}
        size={gridSize}
        columnCount={columnCount}
      ></ThumbnailGrid>
    </Container>
  );
};

export default OwnedNFTList;
